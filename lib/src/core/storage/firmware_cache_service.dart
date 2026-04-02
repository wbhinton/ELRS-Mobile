// Copyright (C) 2026  Weston Hinton [wbhinton@gmail.com]
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:archive/archive.dart';
import 'dart:convert';
import '../../features/flashing/utils/hardware_config_merger.dart';

part 'firmware_cache_service.g.dart';

@Riverpod(keepAlive: true)
FirmwareCacheService firmwareCacheService(Ref ref) {
  return FirmwareCacheService();
}

class FirmwareCacheService {
  Future<String> _getCacheDir() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory(p.join(docsDir.path, 'firmware_cache'));
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir.path;
  }

  /// Returns a list of cached version strings (e.g. ['3.3.0', '3.2.1'])
  /// Only returns versions where BOTH the firmware zip and hardware zip exist.
  Future<List<String>> getCachedVersions() async {
    final dirPath = await _getCacheDir();
    final dir = Directory(dirPath);
    if (!await dir.exists()) return [];

    final List<String> versions = [];
    
    await for (final entity in dir.list()) {
      if (entity is File && entity.path.endsWith('.zip')) {
        final filename = p.basename(entity.path);
        
        // Identify main firmware zips (e.g., expresslrs_v3.3.0.zip)
        if (filename.startsWith('expresslrs_v') && !filename.contains('hardware')) {
          final version = filename.substring('expresslrs_v'.length, filename.length - 4);
          
          // Verify the accompanying hardware zip also exists before yielding
          if (await hasCachedHardwareZip(version)) {
            versions.add(version);
          }
        }
      }
    }
    
    // Sort descending so newest versions appear at the top
    versions.sort((a, b) => b.compareTo(a));
    return versions;
  }

  /// Saves a downloaded zip file to the cache.
  Future<File> saveZip(String version, List<int> bytes) async {
    final dirPath = await _getCacheDir();
    final filePath = p.join(dirPath, 'expresslrs_v$version.zip');
    final file = File(filePath);
    return file.writeAsBytes(bytes);
  }

  /// Saves a downloaded hardware zip file to the cache.
  Future<File> saveHardwareZip(String version, List<int> bytes) async {
    final dirPath = await _getCacheDir();
    final filePath = p.join(dirPath, 'expresslrs_hardware_v$version.zip');
    final file = File(filePath);
    return file.writeAsBytes(bytes);
  }

  /// Gets the file specific to a version if it exists.
  Future<File?> getZipFile(String version) async {
    final dirPath = await _getCacheDir();
    final filePath = p.join(dirPath, 'expresslrs_v$version.zip');
    final file = File(filePath);
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  /// Gets the hardware zip file specific to a version if it exists.
  Future<File?> getHardwareZipFile(String version) async {
    final dirPath = await _getCacheDir();
    final filePath = p.join(dirPath, 'expresslrs_hardware_v$version.zip');
    final file = File(filePath);
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  /// Checks if hardware zip exists for a version.
  Future<bool> hasCachedHardwareZip(String version) async {
    final file = await getHardwareZipFile(version);
    return file != null;
  }

  /// Deletes a cached zip file (and hardware zip).
  Future<void> deleteCachedZip(String version) async {
    final file = await getZipFile(version);
    if (file != null) {
      try {
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {
        // Silently ignore if the file was already deleted by another process
      }
    }

    final hardwareFile = await getHardwareZipFile(version);
    if (hardwareFile != null) {
      try {
        if (await hardwareFile.exists()) {
          await hardwareFile.delete();
        }
      } catch (_) {
        // Silently ignore if the file was already deleted by another process
      }
    }
  }

  /// Deletes all cached firmware files.
  Future<void> clearCache() async {
    final dirPath = await _getCacheDir();
    final dir = Directory(dirPath);
    if (await dir.exists()) {
      await for (final entity in dir.list()) {
        if (entity is File) {
          await entity.delete();
        }
      }
    }
  }

  /// Automatically evicts oldest cached versions to stay under the limit.
  Future<void> evictOldestVersions(int maxVersions) async {
    final dirPath = await _getCacheDir();
    final dir = Directory(dirPath);
    if (!await dir.exists()) return;

    final versions = await getCachedVersions();
    if (versions.length <= maxVersions) return;

    // We need to sort by modification time to find the oldest.
    // However, getCachedVersions only returns version strings.
    // Let's list files and get their stats.
    final List<({String version, DateTime modified})> versionStats = [];

    for (final version in versions) {
      final file = await getZipFile(version);
      if (file != null && await file.exists()) {
        final stat = await file.lastModified();
        versionStats.add((version: version, modified: stat));
      }
    }

    // Sort: Oldest first
    versionStats.sort((a, b) => a.modified.compareTo(b.modified));

    // Calculate how many to delete
    final numToDelete = versions.length - maxVersions;
    for (int i = 0; i < numToDelete; i++) {
      final versionToDelete = versionStats[i].version;
      await deleteCachedZip(versionToDelete);
    }
  }

  /// Returns total cache size in Megabytes.
  Future<double> getCacheSizeMb() async {
    final dirPath = await _getCacheDir();
    final dir = Directory(dirPath);
    int totalBytes = 0;

    if (await dir.exists()) {
      await for (final entity in dir.list()) {
        if (entity is File) {
          totalBytes += await entity.length();
        }
      }
    }
    return totalBytes / (1024 * 1024);
  }

  // --- JSON Caching for Offline Targets ---

  Future<void> saveTargetJson(String version, String jsonString) async {
    final dirPath = await _getCacheDir();
    final filePath = p.join(dirPath, 'targets_$version.json');
    final file = File(filePath);
    await file.writeAsString(jsonString);
    
    // Also save as 'latest' for fallback if version match fails
    final latestPath = p.join(dirPath, 'targets_latest.json');
    await File(latestPath).writeAsString(jsonString);
  }

  Future<String?> getCachedTargetJson(String version) async {
    final dirPath = await _getCacheDir();
    final filePath = p.join(dirPath, 'targets_$version.json');
    final file = File(filePath);
    
    if (await file.exists()) {
      return await file.readAsString();
    }
    
    final latestPath = p.join(dirPath, 'targets_latest.json');
    final latestFile = File(latestPath);
    if (await latestFile.exists()) {
      return await latestFile.readAsString();
    }
    
    return null;
  }

  /// Extracts the base hardware layout from the cached hardware.zip and merges it
  /// with any overlay provided in the target config.
  Future<Map<String, dynamic>> getMergedHardwareLayout(
    String version,
    Map<String, dynamic> targetConfig,
  ) async {
    // 1. Get cached hardware zip
    final zipFile = await getHardwareZipFile(version);
    if (zipFile == null) {
      throw Exception('Hardware zip not found for version $version');
    }

    // 2. Extract base layout
    final layoutFile = targetConfig['layout_file'] as String?;
    if (layoutFile == null) {
      throw Exception('Target config parsing error: layout_file is missing.');
    }

    final bytes = await zipFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    // Find the layout file (e.g. "hardware/layouts/ESP32_2400_RX.json")
    final file = archive.findFile(layoutFile);
    if (file == null) {
      throw Exception('Layout file $layoutFile not found in hardware.zip');
    }

    final content = String.fromCharCodes(file.content as List<int>);
    final baseLayout = jsonDecode(content) as Map<String, dynamic>;

    // 3. Merge Overlay
    final overlay = targetConfig['overlay'] as Map<String, dynamic>?;

    // Import merger to avoid circular deps if possible, or just implement here?
    // User asked to use HardwareConfigMerger.
    // I need to import it.
    return HardwareConfigMerger.mergeOverlay(baseLayout, overlay);
  }
}
