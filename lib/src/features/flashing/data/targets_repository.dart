import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
      final response = await _dio.get(
        'https://raw.githubusercontent.com/ExpressLRS/targets/master/targets.json',
        options: Options(responseType: ResponseType.plain),
      );

      final jsonString = response.data as String;
      // Cache the successful response. Using 'master' as version since we fetch from master
      await _cacheService.saveTargetJson('master', jsonString);

      return await compute(_parseTargets, jsonString);
    } catch (e) {
      _log.warning('Failed to fetch targets online: $e. Checking cache...');
      // Allow fallback to cache
      final cachedJson = await _cacheService.getCachedTargetJson('master');
      if (cachedJson != null && cachedJson.isNotEmpty) {
        return await compute(_parseTargets, cachedJson);
      }

      throw Exception('Failed to fetch targets and no cache available: $e');
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
