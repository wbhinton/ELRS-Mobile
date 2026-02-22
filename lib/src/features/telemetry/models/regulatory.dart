import 'package:binary/binary.dart';

enum RegulatoryDomain {
  fccIsm2g4(0),
  etsiIsm2g4(1),
  unknown(-1);

  final int value;
  const RegulatoryDomain(this.value);

  static RegulatoryDomain fromIndex(Uint8 index) {
    return switch (index.toInt()) {
      0 => RegulatoryDomain.fccIsm2g4,
      1 => RegulatoryDomain.etsiIsm2g4,
      _ => RegulatoryDomain.unknown,
    };
  }

  String get label => switch (this) {
        RegulatoryDomain.fccIsm2g4 => "FCC ISM2G4",
        RegulatoryDomain.etsiIsm2g4 => "ETSI ISM2G4",
        RegulatoryDomain.unknown => "Unknown (Compliance Risk)",
      };
}
