
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:elrs_manager/src/features/flashing/utils/firmware_assembler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Forensics: Compare assembled firmware against golden binary', () async {
    // 1. Load Assets
    final baseFirmwareFile = File('test/assets/base_firmware.bin');
    final hardwareFile = File('test/assets/hardware.json');
    final goldenFile = File('test/assets/golden_firmware.bin');

    if (!baseFirmwareFile.existsSync() || !hardwareFile.existsSync() || !goldenFile.existsSync()) {
      fail('Missing asset files. Ensure base_firmware.bin, hardware.json, and golden_firmware.bin exist in test/assets');
    }

    final baseFirmware = await baseFirmwareFile.readAsBytes();
    
    // DEBUG: Inspect Header
    print('Base Firmware Header: ${baseFirmware.sublist(0, 24)}');
    print('Magic: 0x${baseFirmware[0].toRadixString(16)}');
    print('Segments: ${baseFirmware[1]}');

    // DEBUG: Inspect Tail
    final tailLen = 256;
    final tail = baseFirmware.sublist(baseFirmware.length - tailLen);
    // Print ASCII representation replacing non-printables with '.'
    final tailString = tail.map((b) => (b >= 32 && b <= 126) ? String.fromCharCode(b) : '.').join('');
    print('Base Firmware Tail (ASCII): $tailString');

    final goldenBytes = await goldenFile.readAsBytes();
    final hardwareJsonStr = await hardwareFile.readAsString();
    final hardwareLayout = jsonDecode(hardwareJsonStr) as Map<String, dynamic>;

    // 2. Extract Discriminator from Golden
    // Options block is at len - 2048 (layout) - 512 (options) = len - 2560
    final optionsOffset = goldenBytes.length - 2560;
    final optionsBytes = goldenBytes.sublist(optionsOffset, optionsOffset + 512);
    // Find null terminator
    final nullIndex = optionsBytes.indexOf(0);
    final optionsStr = utf8.decode(optionsBytes.sublist(0, nullIndex != -1 ? nullIndex : 512));
    final goldenOptions = jsonDecode(optionsStr) as Map<String, dynamic>;
    final discriminator = goldenOptions['flash-discriminator'] as int;
    
    print('Golden Discriminator: $discriminator');

    // 3. Assemble Firmware
    // Parameters from user request:
    const phrase = "testphrase";
    const wifiSsid = "testssid";
    const wifiPassword = "testpass";
    const productName = "BETAFPV PWM 2.4GHz RX";
    const luaName = "BFPV PWM 2G4RX";

    final uid = FirmwareAssembler.generateUid(phrase);

    final generatedBytes = FirmwareAssembler.assembleEspUnified(
      firmware: baseFirmware,
      productName: productName,
      luaName: luaName,
      uid: uid,
      hardwareLayout: hardwareLayout,
      wifiSsid: wifiSsid,
      wifiPassword: wifiPassword,
      platform: 'esp8285',
      flashDiscriminator: discriminator, // Use exact value
    );

    // 4. Compare Size
    print('Generated Size: ${generatedBytes.length}');
    print('Golden Size:    ${goldenBytes.length}');

    if (generatedBytes.length != goldenBytes.length) {
      print('SIZE MISMATCH!');
    } else {
      print('Size matches.');
    }

    // 4. Byte-by-Byte Comparison
    bool mismatchFound = false;
    // Iterate up to the length of the shorter file (or generated if same)
    final len = generatedBytes.length < goldenBytes.length ? generatedBytes.length : goldenBytes.length;
    
    // Scan backwards from the end to find structural issues first, as that's likely where our assembly logic differs.
    // Or just scan forward.
    // Let's scan forward to find the FIRST mismatch.
    for (int i = 0; i < len; i++) {
      if (generatedBytes[i] != goldenBytes[i]) {
        print('\nMISMATCH at offset $i (0x${i.toRadixString(16)})');
        print('Generated: 0x${generatedBytes[i].toRadixString(16).padLeft(2,'0')}');
        print('Golden:    0x${goldenBytes[i].toRadixString(16).padLeft(2,'0')}');
        
        // Context
        final start = (i - 16) < 0 ? 0 : i - 16;
        final end = (i + 16) > len ? len : i + 16;
        print('Context (Generated): ${generatedBytes.sublist(start, end)}');
        print('Context (Golden):    ${goldenBytes.sublist(start, end)}');
        
        mismatchFound = true;
        break; // Stop at first mismatch to avoid spam
      }
    }

    // Check specific offsets (from end)
    // Structure:
    // [Trimmed Firmware]
    // [Product 128]
    // [Lua 16]
    // [Options 512]
    // [Layout 2048]
    
    // Layout starts at end - 2048
    final layoutOffset = generatedBytes.length - 2048;
    
    // Options start at end - 2048 - 512 = end - 2560
    final genOptionsOffset = generatedBytes.length - 2560;
    
    if (mismatchFound || generatedBytes.length != goldenBytes.length) {
      print('\n--- DEBUG INFO ---');
      if (genOptionsOffset >= 0 && genOptionsOffset < generatedBytes.length) {
         final genOptsBytes = generatedBytes.sublist(genOptionsOffset, genOptionsOffset + 512);
         final genOptsStr = utf8.decode(genOptsBytes.takeWhile((b) => b != 0).toList());
         print('Generated Options JSON:\n$genOptsStr');
         
         final goldenOffset = goldenBytes.length - 2560;
         final goldenOptsBytes = goldenBytes.sublist(goldenOffset, goldenOffset + 512);
         final goldenOptsStr = utf8.decode(goldenOptsBytes.takeWhile((b) => b != 0).toList());
         print('Golden Options JSON:\n$goldenOptsStr');
      }
      
      fail('Firmware binary mismatch detected.');
    } else {
      print('SUCCESS: Generated firmware matches golden binary exactly.');
    }
  });
}
