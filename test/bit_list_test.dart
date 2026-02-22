import 'package:binary/binary.dart';
// Use a prefixed import so our BitList doesn't collide with package:binary's own BitList.
import 'package:elrs_mobile/src/bit_list.dart' as elrs_bits;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BitList', () {
    group('parity with nthBit (WYSIWIS)', () {
      // Sample values exercising both set and clear bits across the register.
      // Values written as hex to avoid Dart binary-literal parse ambiguity.
      const samples = <int>[
        0x00,       // all clear
        0xFF,       // all set
        0xAA,       // 0b10101010
        0x69,       // 0b01101001
        0xA3,       // mixed
      ];

      for (final raw in samples) {
        test('Uint8(0x${raw.toRadixString(16).padLeft(2, '0')}) — '
            'BitList[i] == nthBit(i) for all 8 bits', () {
          final reg = Uint8(raw);
          final bits = elrs_bits.BitList.fromInt(reg.toInt(), length: 8);

          for (var i = 0; i < 8; i++) {
            expect(
              bits[i],
              equals(reg.nthBit(i)),
              reason: 'Mismatch at bit $i for value 0x${raw.toRadixString(16)}',
            );
          }
        });
      }

      test('Uint16 register — BitList[i] == nthBit(i) for all 16 bits', () {
        const raw = 0xCAFE;
        final reg = Uint16(raw);
        final bits = elrs_bits.BitList.fromInt(reg.toInt(), length: 16);

        for (var i = 0; i < 16; i++) {
          expect(
            bits[i],
            equals(reg.nthBit(i)),
            reason: 'Mismatch at bit $i for value 0x${raw.toRadixString(16)}',
          );
        }
      });
    });

    group('length', () {
      test('reports correct length for 8-bit BitList', () {
        final bits = elrs_bits.BitList.fromInt(0xFF, length: 8);
        expect(bits.length, 8);
      });

      test('reports correct length for 16-bit BitList', () {
        final bits = elrs_bits.BitList.fromInt(0xFFFF, length: 16);
        expect(bits.length, 16);
      });

      test('length setter throws UnsupportedError', () {
        final bits = elrs_bits.BitList.fromInt(0, length: 8);
        expect(() => bits.length = 4, throwsUnsupportedError);
      });
    });

    group('index operator', () {
      test('correctly identifies set and clear bits', () {
        // 0x08 == 0b00001000 — only bit 3 is set
        final bits = elrs_bits.BitList.fromInt(0x08, length: 8);
        expect(bits[3], isTrue);
        for (var i = 0; i < 8; i++) {
          if (i != 3) expect(bits[i], isFalse, reason: 'Expected bit $i to be clear');
        }
      });

      test('throws RangeError for negative index', () {
        final bits = elrs_bits.BitList.fromInt(0xFF, length: 8);
        expect(() => bits[-1], throwsRangeError);
      });

      test('throws RangeError for index >= length', () {
        final bits = elrs_bits.BitList.fromInt(0xFF, length: 8);
        expect(() => bits[8], throwsRangeError);
      });
    });

    group('immutability', () {
      test('[]= throws UnsupportedError', () {
        final bits = elrs_bits.BitList.fromInt(0x00, length: 8);
        expect(() => bits[0] = true, throwsUnsupportedError);
      });
    });

    group('PWM channel simulation', () {
      test('16-channel BitList parity — all bits agree with Uint8 nthBit '
          '(upper 8 bits always false for both when value fits in Uint8)', () {
        // Mirrors the exact pattern in PwmScreen.itemBuilder.
        const currentChannel = 5; // mid-range channel index
        final rawReg = Uint8(currentChannel);
        final configBits = elrs_bits.BitList.fromInt(rawReg.toInt(), length: 16);

        for (var i = 0; i < 8; i++) {
          // Within Uint8 range — both must agree.
          expect(configBits[i], equals(rawReg.nthBit(i)),
              reason: 'Parity failure at bit $i');
        }
        for (var i = 8; i < 16; i++) {
          // Upper bits are always 0 on a Uint8 register, and BitList must match.
          expect(configBits[i], isFalse,
              reason: 'Expected upper bit $i to be false');
        }
      });
    });
  });
}
