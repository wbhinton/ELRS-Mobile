import 'dart:typed_data';

import 'package:binary/binary.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Hardware Logic Integrity Test Suite
//
// Validates three layers of the ELRS register pipeline:
//   1. Telemetry Gatekeeping  — Uint8.checkRange() as the type-width enforcer
//   2. Modular Wrap-around    — wrappedAdd() matching hardware register overflow
//   3. Round-trip Parity      — UI config bit → Uint8List transmission → re-parse
// ---------------------------------------------------------------------------

void main() {
  group('Hardware Logic Integrity', () {
    // -----------------------------------------------------------------------
    // 1. Telemetry Gatekeeping via checkRange
    //
    // The device firmware enforces 8-bit register widths. Any telemetry value
    // wider than a byte is a data-fidelity violation and must be rejected
    // before it can corrupt the model layer.
    // -----------------------------------------------------------------------
    group('Telemetry Gatekeeping via checkRange', () {
      test('accepts values at the valid boundary edges', () {
        // Floor and ceiling of an 8-bit unsigned register
        expect(Uint8.checkRange(Uint8.minInt), equals(Uint8.zero));
        expect(Uint8.checkRange(Uint8.maxInt), equals(Uint8.max));
      });

      test('accepts mid-range byte value and returns the correct Uint8', () {
        const validByte = 0x7F; // 127 — largest positive signed-byte value
        expect(Uint8.checkRange(validByte), equals(Uint8(0x7F)));
      });

      test('rejects value just above maxInt with RangeError', () {
        const invalidByte = 0x100; // 256 — one beyond a Uint8
        expect(
          () => Uint8.checkRange(invalidByte),
          throwsA(isA<RangeError>()),
        );
      });

      test('rejects negative value with RangeError', () {
        expect(
          () => Uint8.checkRange(-1),
          throwsA(isA<RangeError>()),
        );
      });

      test('tryFrom returns null for out-of-range values (non-throwing gate)', () {
        // Establishes that tryFrom and checkRange are complementary strategies.
        expect(Uint8.tryFrom(0xFF), equals(Uint8(255)));
        expect(Uint8.tryFrom(0x100), isNull);
        expect(Uint8.tryFrom(-1), isNull);
      });
    });

    // -----------------------------------------------------------------------
    // 2. Modular Wrap-around Parity
    //
    // Hardware registers are fixed-width; overflow wraps rather than saturates.
    // wrappedAdd() must mirror actual device behaviour so UI rollover states
    // (e.g. frame-counter, telemetry sequence IDs) are modelled correctly.
    // -----------------------------------------------------------------------
    group('Modular Wrap-around Parity', () {
      test('255 + 1 wraps to 0 (hardware register overflow)', () {
        final reg = Uint8(255);
        expect(reg.wrappedAdd(Uint8(1)), equals(Uint8.zero));
      });

      test('0 - 1 wraps to 255 via wrappedSubtract (underflow completeness)', () {
        final reg = Uint8.zero;
        expect(reg.wrappedSubtract(Uint8(1)), equals(Uint8(255)));
      });

      test('mid-range addition does not wrap', () {
        // 100 + 50 = 150, well within Uint8 bounds
        expect(Uint8(100).wrappedAdd(Uint8(50)), equals(Uint8(150)));
      });

      test('saturating add via clampedAdd does not overflow', () {
        // Proves clampedAdd and wrappedAdd diverge at boundary — by design.
        final clamped = Uint8(255).clampedAdd(Uint8(1));
        final wrapped = Uint8(255).wrappedAdd(Uint8(1));
        expect(clamped, equals(Uint8(255))); // Clamped: stays at max
        expect(wrapped, equals(Uint8.zero)); // Wrapped: rolls over to 0
        expect(clamped, isNot(equals(wrapped)));
      });
    });

    // -----------------------------------------------------------------------
    // 3. Round-trip Parity: UI → ByteList → Model
    //
    // When a user enables a PWM channel in the UI the change must survive:
    //   a. Encoding into a Uint8 config register (setNthBit)
    //   b. Serialisation into a Uint8List for transmission (viewOrCopyAsBytes)
    //   c. Re-parsing at the model layer (Uint8 constructor + nthBit)
    //
    // This test is the end-to-end "WYSIWIS" contract for the config pipeline.
    // -----------------------------------------------------------------------
    group('Round-trip Parity (UI → ByteList → Model)', () {
      test('bit 5 set by UI survives transmission and re-parse (2^5 == 32)', () {
        // Step 1 — Simulate UI enabling PWM Channel 5 (bit index 5).
        final initialConfig = Uint8.zero;
        final modifiedConfig = initialConfig.setNthBit(5, true);

        expect(modifiedConfig.toInt(), equals(32), reason: '2^5 == 32');
        expect(modifiedConfig.nthBit(5), isTrue);

        // Step 2 — Serialise for transmission (UI → wire).
        // viewOrCopyAsBytes avoids a copy when the input is already typed.
        final buffer = Uint8List.fromList([modifiedConfig.toInt()]);
        final wireBytes = viewOrCopyAsBytes(buffer);

        expect(wireBytes.length, equals(1));
        expect(wireBytes[0], equals(32));

        // Step 3 — Re-parse at the model layer (wire → model).
        final parsedConfig = Uint8(wireBytes[0]);
        expect(parsedConfig.nthBit(5), isTrue,
            reason: 'Bit 5 must still be set after round-trip');
        expect(parsedConfig.toInt(), equals(32),
            reason: 'Integer value must be identical after round-trip');
      });

      test('round-trip preserves all bits for a multi-bit config byte', () {
        // Set bits 0, 3, and 7 simultaneously (value = 1 + 8 + 128 = 137 = 0x89)
        var config = Uint8.zero;
        config = config.setNthBit(0, true);
        config = config.setNthBit(3, true);
        config = config.setNthBit(7, true);

        expect(config.toInt(), equals(0x89));

        // Serialise and re-parse
        final wireBytes = viewOrCopyAsBytes(Uint8List.fromList([config.toInt()]));
        final parsed = Uint8(wireBytes[0]);

        expect(parsed.nthBit(0), isTrue);
        expect(parsed.nthBit(1), isFalse);
        expect(parsed.nthBit(2), isFalse);
        expect(parsed.nthBit(3), isTrue);
        expect(parsed.nthBit(4), isFalse);
        expect(parsed.nthBit(5), isFalse);
        expect(parsed.nthBit(6), isFalse);
        expect(parsed.nthBit(7), isTrue);
        expect(parsed.toInt(), equals(config.toInt()),
            reason: 'Complete register must be identical after round-trip');
      });

      test('clearing a bit survives round-trip', () {
        // Start with all bits set, then clear bit 3.
        var config = Uint8.max;
        config = config.setNthBit(3, false);

        expect(config.nthBit(3), isFalse);
        expect(config.toInt(), equals(0xFF - 8), reason: '0xFF - 2^3 == 247');

        // Round-trip
        final parsed = Uint8(viewOrCopyAsBytes(Uint8List.fromList([config.toInt()]))[0]);
        expect(parsed.nthBit(3), isFalse);
        expect(parsed.toInt(), equals(config.toInt()));
      });

      test('viewOrCopyAsBytes returns a Uint8List view with correct bytes', () {
        // viewOrCopyAsBytes always returns a Uint8List typed-data view.
        // For a Uint8List input it calls buffer.asUint8List() (avoids deep copy);
        // for a plain List<int> it falls back to Uint8List.fromList() (copies).
        // Either way the returned bytes must be identical to the input.
        final original = Uint8List.fromList([0xCA, 0xFE]);
        final viewed = viewOrCopyAsBytes(original);

        expect(viewed, isA<Uint8List>());
        expect(viewed, equals([0xCA, 0xFE]));
        expect(viewed.length, equals(2));

        // For a plain List<int> input the result is still a Uint8List.
        final plainList = <int>[0xBE, 0xEF];
        final copied = viewOrCopyAsBytes(plainList);
        expect(copied, isA<Uint8List>());
        expect(copied, equals([0xBE, 0xEF]));
      });
    });
  });
}
