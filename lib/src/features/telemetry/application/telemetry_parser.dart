import 'package:binary/binary.dart';
import '../models/regulatory.dart';

/// Refactor: Extracting Regulatory Domain Index (Bits 0-3)
void parseRegulatoryTelemetry(int rawByte) {
  // Use Uint8 to enforce width and gain access to .chunk()
  final telemetry = Uint8(rawByte);
  
  // Extract 4-bit index starting at bit 0
  // Refactor isolated the domain bits using the .chunk() method
  final domainIndex = telemetry.chunk(0, 4);
  
  final domain = RegulatoryDomain.fromIndex(domainIndex);
  print('Resolved Domain: ${domain.label}');
}
