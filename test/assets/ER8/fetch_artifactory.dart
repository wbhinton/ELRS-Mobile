import 'dart:io';
import 'package:dio/dio.dart';
import 'package:archive/archive.dart';

void main() async {
  final dio = Dio();
  try {
    print('Fetching index...');
    final idxResp = await dio.get('https://artifactory.expresslrs.org/ExpressLRS/index.json');
    final tags = idxResp.data['tags'] as Map<String, dynamic>;
    
    // We'll just grab the latest 3.3.x or 3.4.x version. What's the latest?
    final version = '3.6.3';
    final hash = tags[version];
    print('Using version $version with hash $hash');
    
    print('Downloading firmware.zip...');
    final zipResp = await dio.get<List<int>>(
      'https://artifactory.expresslrs.org/ExpressLRS/$hash/firmware.zip',
      options: Options(responseType: ResponseType.bytes)
    );
    
    final archive = ZipDecoder().decodeBytes(zipResp.data!);
    
    // Find the ER8 firmware
    ArchiveFile? matched;
    for (final file in archive) {
      if (file.name.endsWith('.bin')) {
        print('Available firmware: ${file.name}');
        if (file.name.contains('ER8') || file.name.contains('Unified_ESP32_2400_RX')) {
          matched = file;
          // Don't break so we can print all available firmwares
        }
      }
    }
    
    if (matched != null) {
      final bytes = matched.content as List<int>;
      print('Found ${matched.name}, size: ${bytes.length}');
      
      final seq = [0xBE, 0xEF, 0xCA, 0xFE];
      int offset = -1;
      for (int i = 0; i < bytes.length - 4; i++) {
        if (bytes[i] == seq[0] && bytes[i+1] == seq[1] && bytes[i+2] == seq[2] && bytes[i+3] == seq[3]) {
          offset = i;
          break;
        }
      }
      
      if (offset != -1) {
        print('BEEFCAFE found at $offset (0x${offset.toRadixString(16)})');
        final snippet = bytes.sublist(offset, offset + 32);
        print('Hex: ${snippet.map((b) => b.toRadixString(16).padLeft(2, "0")).join(" ")}');
      } else {
        print('BEEFCAFE not found in this version.');
      }
    } else {
      print('Target not found in zip');
    }
  } catch (e) {
    print('Error: $e');
  }
}
