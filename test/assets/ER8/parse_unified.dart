import 'dart:io';

void main() async {
  final fileA = File('test/assets/ER8/generated_er8.bin');
  final fileB = File('test/assets/ER8/er8_golden_firmware.bin');
  
  final bytesA = await fileA.readAsBytes();
  final bytesB = await fileB.readAsBytes();
  
  // Find "UNIFIED" in golden
  final unified = [0x55, 0x4E, 0x49, 0x46, 0x49, 0x45, 0x44];
  int goldenUnified = -1;
  for (int i = 0; i < bytesB.length - 7; i++) {
    bool found = true;
    for (int j = 0; j < 7; j++) {
      if (bytesB[i+j] != unified[j]) {
        found = false;
        break;
      }
    }
    if (found) {
      goldenUnified = i;
      break;
    }
  }
  
  print('Golden UNIFIED offset: 0x${goldenUnified.toRadixString(16)}');
  print('Golden string: ${String.fromCharCodes(bytesB.sublist(goldenUnified, goldenUnified + 32))}');
  
  // Let's see what is at that exact offset in generated
  if (goldenUnified != -1) {
    print('Generated at same offset:');
    final start = goldenUnified - 4 >= 0 ? goldenUnified - 4 : 0;
    final end = start + 32 < bytesA.length ? start + 32 : bytesA.length;
    final snippet = bytesA.sublist(start, end);
    print('  Hex: ${snippet.map((b) => b.toRadixString(16).padLeft(2, "0")).join(" ")}');
    // Try to print as string, replacing unprintables
    final strSnippet = snippet.map((b) => b >= 32 && b <= 126 ? String.fromCharCode(b) : '.').join("");
    print('  Str: $strSnippet');
  }
}
