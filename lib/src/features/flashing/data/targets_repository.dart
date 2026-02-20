import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../domain/target_definition.dart';
import '../../../core/storage/firmware_cache_service.dart';

class TargetsRepository {
  final Dio _dio;
  final FirmwareCacheService _cacheService;


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
      print('Failed to fetch targets online: $e. Checking cache...');
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

    // The targets.json structure is typically:
    // {
    //   "vendor1": {
    //     "device1": { ... },
    //     "device2": { ... }
    //   },
    //   "vendor2": { ... }
    // }
    // We need to flatten this into a list of TargetDefinition objects.
    // However, the user request implied a simpler list or direct mapping. 
    // Given the complexity of targets.json, we'll implement a recursive or nested parsing logic
    // if we needed to preserve the structure, but here we will try to iterate through vendors and devices.

    // Wait, the user said: "The model should represent an ELRS Target... based on targets.json".
    // And "Map the 'firmware' key if it exists, or use a dynamic map".
    
    // Structure:
    // VendorKey -> { "name": "Visual Name", "category1": { "device1": {...} }, ... }
    
    jsonMap.forEach((vendorKey, vendorData) {
      if (vendorData is Map<String, dynamic>) {
        // extract vendor display name
        final String vendorName = vendorData['name'] as String? ?? vendorKey;
        
        vendorData.forEach((categoryKey, categoryData) {
           // Skip "name" field at this level
           if (categoryKey == 'name') return;
           
           if (categoryData is Map<String, dynamic>) {
              // This is a category (e.g. rx_2400, tx_900)
              // Iterate over devices in this category
              categoryData.forEach((deviceKey, deviceData) {
                 if (deviceData is Map<String, dynamic>) {
                    // This is the actual device target definition
                    final data = Map<String, dynamic>.from(deviceData);
                    
                    // Inject metadata
                    data['vendor'] = vendorName; // Use display name for UI
                    data['name'] ??= deviceData['product_name'] ?? deviceKey;
                    
                    // category can be useful too?
                    // data['category'] = categoryKey; 
                    
                    try {
                      // Map fields to TargetDefinition
                      // TargetDefinition expects 'vendor', 'name', 'product_code', 'firmware', 'config'
                      // The JSON has 'product_name', 'lua_name', 'upload_methods'.
                      // We might need to map 'product_name' to 'name'? (Done above)
                      // 'firmware'? Is it in the JSON? 
                      // Sometimes 'firmware' is implied or not present?
                      // The debug script showed 'platform': 'esp82...', 'layout_file'...
                      // It doesn't explicitly have 'firmware' or 'product_code' usually?
                      // Wait, 'product_name' is the friendly name.
                      // 'product_code' is usually not there? Or is it used for matching?
                      // If 'firmware' is missing, we might use the key 'deviceKey' or constructs.
                      
                      // Important: Model expects 'product_code' for matching?
                      // Or 'firmware'?
                      // Let's set 'product_code' to deviceKey if missing?
                      if (data['product_code'] == null) {
                         data['product_code'] = deviceKey;
                      }
                      
                      // 'firmware' field: 
                      // If the JSON doesn't have it, we might need to derive it?
                      // For Artifactory matching, we need the folder name in the zip.
                      // Is `deviceKey` the folder name?
                      // e.g. "single-radio" -> "anyleaf_2400_rx_single" ??
                      // Or is `deviceData['firmware']` present?
                      // If not present, we might have trouble matching.
                      // Let's assume for now we pass what we have, and debug if it's missing.
                      
                      // Ensure important fields are preserved in 'config' map since TargetDefinition might not have specific fields for them
                      // and we want to avoid regenerating code if possible.
                      if (data['config'] == null) {
                        data['config'] = <String, dynamic>{};
                      }
                      final configMap = data['config'] as Map<String, dynamic>;
                      
                      // Inject layout_file and overlay for hardware merging
                      if (data.containsKey('layout_file')) configMap['layout_file'] = data['layout_file'];
                      if (data.containsKey('overlay')) configMap['overlay'] = data['overlay'];
                      
                      // Inject identifying names for Unified Builder
                      if (data.containsKey('lua_name')) configMap['lua_name'] = data['lua_name'];
                      if (data.containsKey('product_name')) configMap['product_name'] = data['product_name'];
                      
                      // Ensure config is passed back to data
                      data['config'] = configMap;

                      // Extract platform
                      data['platform'] ??= deviceData['platform'];

                      targets.add(TargetDefinition.fromJson(data));
                    } catch (e) {
                      print('Error parsing target $deviceKey in $vendorKey: $e');
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
