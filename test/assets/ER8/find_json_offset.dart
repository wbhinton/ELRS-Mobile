import 'dart:io';

void main() async {
  final file = File('test/assets/ER8/generated_er8.bin');
  final bytes = await file.readAsBytes();
  
  final str = String.fromCharCodes(bytes);
  final idx = str.indexOf('{"flash-discriminator"');
  if (idx != -1) {
    print('Golden JSON starts exactly at: $idx (0x${idx.toRadixString(16)})');
    // Check 200 bytes before it
    final beforeIdx = idx > 200 ? idx - 200 : 0;
    print('Context before JSON:\n${str.substring(beforeIdx, idx)}');
  } else {
    print('JSON not found in golden firmware!');
  }
}
