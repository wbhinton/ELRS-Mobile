import 'dart:io';
import 'dart:typed_data';

void main() async {
  final fileA = File('test/assets/ER8/generated_er8.bin');
  final fileB = File('test/assets/ER8/er8_golden_firmware.bin');

  final bytesA = await fileA.readAsBytes();
  final bytesB = await fileB.readAsBytes();
  
  // We know the mismatch is at 0x115E58
  // Let's just convert block 1138000 to 1139000 to String and print diff
  final start = 1138000;
  final end = 1139000;
  
  final strA = String.fromCharCodes(bytesA.sublist(start, end));
  final strB = String.fromCharCodes(bytesB.sublist(start, end));

  print('=== STR A ===');
  print(strA);
  print('\n=== STR B ===');
  print(strB);
  
  // Actually let's compare byte by byte and skip the flash-discriminator value
  int firstMismatch = -1;
  for (int i = 0; i < bytesA.length; i++) {
    if (bytesA[i] != bytesB[i]) {
       // Look at the text context to see if it's flash-discriminator
       final ctx = String.fromCharCodes(bytesA.sublist(i > 20 ? i - 20 : 0, i));
       if (ctx.contains('nator":')) {
           // Skip digits in both
           while(i < bytesA.length && bytesA[i] >= 48 && bytesA[i] <= 57) i++;
           // We might need to resync B
           // This is just a script, let's just print the finding and break.
       } else {
           firstMismatch = i;
           break;
       }
    }
  }
  
  print('\nFIRST TRUE FATAL MISMATCH: ${firstMismatch == -1 ? "NONE!" : "0x" + firstMismatch.toRadixString(16)}');
}
