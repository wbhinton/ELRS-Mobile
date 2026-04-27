import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logging/logging.dart';
import '../domain/target_definition.dart';
import '../../../core/storage/firmware_cache_service.dart';

class TargetsRepository {
  final Dio _dio;
  final FirmwareCacheService _cacheService;
  static final _log = Logger('TargetsRepository');

  TargetsRepository(this._dio, this._cacheService);

  Future<List<TargetDefinition>> fetchTargets() async {
    try {
      // Tier 1: Network & Cache Save
      final response = await _dio.get(
        'https://raw.githubusercontent.com/ExpressLRS/targets/master/targets.json',
        options: Options(responseType: ResponseType.plain),
      );

      final jsonString = response.data as String;
      // Cache the successful response as 'latest'
      await _cacheService.saveTargetJson('latest', jsonString);

      return await compute(_parseTargets, jsonString);
    } on DioException catch (e) {
      _log.warning('Network fetch failed ($e). Attempting to load from cache...');
      
      // Tier 2: Cache Load
      final cachedJson = await _cacheService.getCachedTargetJson('latest');
      if (cachedJson != null && cachedJson.isNotEmpty) {
        _log.info('Successfully loaded targets from cache.');
        return await compute(_parseTargets, cachedJson);
      }

      // Tier 3: Asset Fallback
      _log.warning('No cached targets available. Falling back to bundled assets...');
      try {
        final bundleJson = await rootBundle.loadString('assets/targets.json');
        _log.info('Successfully loaded targets from bundled assets.');
        return await compute(_parseTargets, bundleJson);
      } catch (assetError) {
        _log.severe('Failed to load bundled targets: $assetError');
        throw Exception('Failed to fetch targets from network, cache, and bundle.');
      }
    } catch (e) {
      _log.severe('Unexpected error during target fetching: $e');
      rethrow;
    }
  }

  static List<TargetDefinition> _parseTargets(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final List<TargetDefinition> targets = [];

    // Flattens the nested targets.json structure into a list of TargetDefinition objects.
    // VendorKey -> { "name": "Visual Name", "category": { "device": {...} }, ... }
    jsonMap.forEach((vendorKey, vendorData) {
      if (vendorData is Map<String, dynamic>) {
        final String vendorName = vendorData['name'] as String? ?? vendorKey;

        vendorData.forEach((categoryKey, categoryData) {
          if (categoryKey == 'name') return;

          if (categoryData is Map<String, dynamic>) {
            categoryData.forEach((deviceKey, deviceData) {
              if (deviceData is Map<String, dynamic>) {
                final data = Map<String, dynamic>.from(deviceData);
                
                data['vendor'] = vendorName;
                data['name'] ??= deviceData['product_name'] ?? deviceKey;

                final parts = categoryKey.split('_');
                if (parts.length == 2) {
                  data['device_type'] = parts[0].toUpperCase();
                  final freq = parts[1];
                  data['frequency_type'] = freq == '2400' ? '2.4GHz' : 
                                           freq == '900' ? '900MHz' : 
                                           freq == 'dual' ? 'Dual Band' : freq;
                }

                try {
                  if (data['product_code'] == null) {
                    data['product_code'] = deviceKey;
                  }

                  if (data['config'] == null) {
                    data['config'] = <String, dynamic>{};
                  }
                  
                  final configMap = data['config'] as Map<String, dynamic>;

                  if (data.containsKey('product_name')) {
                    configMap['product_name'] = data['product_name'];
                  }
                  if (data.containsKey('lua_name')) {
                    configMap['lua_name'] = data['lua_name'];
                  }

                  // Inject layout_file and overlay for hardware merging
                  if (data.containsKey('layout_file')) {
                    configMap['layout_file'] = data['layout_file'];
                  }
                  if (data.containsKey('overlay')) {
                    configMap['overlay'] = data['overlay'];
                  }

                  // Ensure config is passed back to data
                  data['config'] = configMap;

                  // Extract platform
                  data['platform'] ??= deviceData['platform'];

                  data['category'] = categoryKey;
                  targets.add(TargetDefinition.fromJson(data));
                } catch (e) {
                  _log.warning('Error parsing target $deviceKey in $vendorKey: $e');
                }
              }
            });
          }
        });
      }
    });

    return targets;
  }
}
