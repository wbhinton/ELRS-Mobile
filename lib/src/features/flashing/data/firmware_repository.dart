import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:archive/archive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firmware_repository.g.dart';

class FirmwareData {
  final Uint8List bytes;
  final String filename;
  
  const FirmwareData({
    required this.bytes,
    required this.filename,
  });
}

class FirmwareRepository {
  final Dio _dio;

  FirmwareRepository(this._dio);

  Future<FirmwareData> downloadFirmware(
    String targetName,
    String version, {
    int regulatoryDomain = 0, // 0 = FCC, 1 = LBT (EU)
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final zipBytes = await downloadFirmwareZip(
        version,
        onReceiveProgress: onReceiveProgress,
      );
      print('Zip downloaded (${zipBytes.length} bytes). Extracting...');
      
      return extractFirmwareFromZip(zipBytes, targetName, regulatoryDomain: regulatoryDomain);
    } catch (e) {
      print('Firmware download error: $e');
      throw Exception('Failed to download/extract firmware: $e');
    }
  }

  /// Fetches the commit hash for a given version from the Artifactory index.
  Future<String> fetchHashForVersion(String version) async {
    try {
      print('Fetching Artifactory Index...');
      final indexResponse = await _dio.get('https://artifactory.expresslrs.org/ExpressLRS/index.json');
      final tags = indexResponse.data['tags'] as Map<String, dynamic>;

      if (!tags.containsKey(version)) {
        throw Exception('Version $version not found in Artifactory index.');
      }

      final hash = tags[version];
      print('Found hash for $version: $hash');
      return hash as String;
    } catch (e) {
      print('FIRMWARE: Hash fetch failed (Offline?). Error: $e');
      rethrow;
    }
  }

  /// Downloads an artifact by filename for a specific commit hash.
  Future<List<int>> downloadArtifact(
    String hash, 
    String filename, {
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final url = 'https://artifactory.expresslrs.org/ExpressLRS/$hash/$filename';
      print('Downloading artifact: $url');

      final response = await _dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: onReceiveProgress,
      );

      return response.data as List<int>;
    } catch (e) {
      throw Exception('Failed to download $filename: $e');
    }
  }

  /// Downloads the firmware zip file from Artifactory.
  /// Kept for backward compatibility but implemented using new helpers.
  Future<List<int>> downloadFirmwareZip(
    String version, {
    void Function(int, int)? onReceiveProgress,
  }) async {
    final hash = await fetchHashForVersion(version);
    return downloadArtifact(
      hash, 
      'firmware.zip', 
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Downloads the hardware zip file from the fixed URL.
  Future<List<int>> downloadHardwareZip({
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      const url = 'https://artifactory.expresslrs.org/ExpressLRS/hardware.zip';
      print('Downloading hardware zip: $url');

      final response = await _dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: onReceiveProgress,
      );

      return response.data as List<int>;
    } catch (e) {
      throw Exception('Failed to download hardware zip: $e');
    }
  }

  /// Extracts the firmware binary from a zip byte array.
  Future<FirmwareData> extractFirmwareFromZip(
    List<int> zipBytes,
    String targetName, {
    int regulatoryDomain = 0,
  }) async {
    try {
      // 3. Extract & Search
      final archive = ZipDecoder().decodeBytes(zipBytes);
      
      // Zip Structure: firmware/FCC/TargetName/firmware.bin OR firmware/LBT/TargetName/firmware.bin
      // We need to match the folder name to the targetName.
      // Example: targetName="Unified_ESP32_2400_RX", we look for "*/Unified_ESP32_2400_RX/firmware.bin" or ".bin.gz"
      
      ArchiveFile? matchedFile;
      final candidates = <String>[];

      for (final file in archive) {
        if (!file.isFile) continue;
        final name = file.name;
        
        if (name.endsWith('.bin') || name.endsWith('.bin.gz')) {
           candidates.add(name);
           
           // Check if this file is the firmware match inside the target folder
           // Expected: firmware/DOMAIN/TARGET_NAME/firmware.bin(.gz)
           if (name.contains('/$targetName/') && (name.endsWith('firmware.bin') || name.endsWith('firmware.bin.gz'))) {
              // Check Domain
              // Domain 0 = FCC? Usually 'FCC' folder.
              // Domain 1 = LBT (EU)? Usually 'LBT' folder.
              final isLbt = name.contains('/LBT/');
              final isFcc = name.contains('/FCC/'); // Or just not LBT?
              
              if (regulatoryDomain == 1 && isLbt) {
                 matchedFile = file;
                 break;
              } else if (regulatoryDomain == 0 && (isFcc || !isLbt)) {
                 // Prefer FCC or non-LBT
                 matchedFile = file;
                 break; 
              }
              
              if (matchedFile == null) matchedFile = file;
           }
        }
      }

      if (matchedFile == null) {
        print('No matching firmware found for target: $targetName');
        print('Available candidates in zip:');
        for (final c in candidates) {
          print(' - $c');
        }
        throw Exception('Firmware file for $targetName not found in release archive.');
      }

      print('Extracted match: ${matchedFile.name}');
      final fileContent = matchedFile.content as List<int>;
      // Extract the filename from the path (e.g. firmware/FCC/Target/firmware.bin -> firmware.bin)
      // Actually we want the full name or just the basename? User said "actual filename found (e.g., BetaFPV_Nano_RX.bin.gz)".
      // Wait, zip structure is usually `firmware/FCC/TargetName/firmware.bin`.
      // The user EXAMPLE says "BetaFPV_Nano_RX.bin.gz".
      // If the file inside zip is strictly named `firmware.bin`, then we return `firmware.bin`.
      // If it's named `firmware.bin.gz`, we return that.
      // I will return the basename of the matched file.
      final filename = matchedFile.name.split('/').last;
      
      return FirmwareData(
        bytes: Uint8List.fromList(fileContent),
        filename: filename,
      );

    } catch (e) {
      throw Exception('Failed to extract: $e');
    }
  }
}

@riverpod
FirmwareRepository firmwareRepository(Ref ref) {
  return FirmwareRepository(Dio());
}
