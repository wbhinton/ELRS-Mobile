import 'package:elrs_mobile/src/core/utils/binding_phrase_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BindingPhraseUtils', () {
    test('Generates correct UID for standard phrase', () {
      // Setup
      const phrase = 'expresslrs';
      // Expected UID for "-DMY_BINDING_PHRASE=\"expresslrs\""
      // Verified against ELRS JS logic: MD5("-DMY_BINDING_PHRASE=\"expresslrs\"") = 41f521e63ae2ce90029b691bbc9109b4
      // First 6 bytes: [0x41, 0xF5, 0x21, 0xE6, 0x3A, 0xE2] -> [65, 245, 33, 230, 58, 226]
      final expectedUid = [65, 245, 33, 230, 58, 226];

      // Act
      final uid = BindingPhraseUtils.generateUid(phrase);

      // Assert
      expect(uid, equals(expectedUid));
    });

    test('Generates empty UID for empty phrase', () {
      final uid = BindingPhraseUtils.generateUid('');
      expect(uid, equals([0, 0, 0, 0, 0, 0]));
    });
  });
}
