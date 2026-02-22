import 'package:flutter_test/flutter_test.dart';
import 'package:binary/binary.dart';
import 'package:elrs_mobile/src/features/telemetry/models/regulatory.dart';
import 'package:elrs_mobile/src/features/telemetry/application/telemetry_parser.dart';

void main() {
  group('Telemetry Ingestion Layer Audit', () {
    test('RegulatoryDomain.fromIndex handles valid indices', () {
      expect(RegulatoryDomain.fromIndex(Uint8(0)), RegulatoryDomain.fccIsm2g4);
      expect(RegulatoryDomain.fromIndex(Uint8(1)), RegulatoryDomain.etsiIsm2g4);
    });

    test('RegulatoryDomain.fromIndex handles unknown indices', () {
      expect(RegulatoryDomain.fromIndex(Uint8(2)), RegulatoryDomain.unknown);
      expect(RegulatoryDomain.fromIndex(Uint8(15)), RegulatoryDomain.unknown);
    });

    test('RegulatoryDomain label mapping', () {
      expect(RegulatoryDomain.fccIsm2g4.label, "FCC ISM2G4");
      expect(RegulatoryDomain.etsiIsm2g4.label, "ETSI ISM2G4");
      expect(RegulatoryDomain.unknown.label, "Unknown (Compliance Risk)");
    });

    test('parseRegulatoryTelemetry extracts domain bits correctly (0-3)', () {
      // 0xC1 = 1100 0001
      // Bits 0-3 = 0001 (1) -> ETSI
      expect(() => parseRegulatoryTelemetry(0xC1), prints(contains('Resolved Domain: ETSI ISM2G4\n')));

      // 0xD0 = 1101 0000
      // Bits 0-3 = 0000 (0) -> FCC
      expect(() => parseRegulatoryTelemetry(0xD0), prints(contains('Resolved Domain: FCC ISM2G4\n')));

      // 0xE2 = 1110 0010
      // Bits 0-3 = 0010 (2) -> Unknown
      expect(() => parseRegulatoryTelemetry(0xE2), prints(contains('Resolved Domain: Unknown (Compliance Risk)\n')));
    });
  });
}
