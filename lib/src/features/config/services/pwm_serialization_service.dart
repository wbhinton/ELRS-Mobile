import 'dart:typed_data';
import 'package:binary/binary.dart';
import '../domain/pwm_config.dart';

/// Service responsible for serializing ELRS configuration data.
/// 
/// Strictly adheres to [Endian.little] as required by the ELRS/CRSF hardware protocol.
class PwmSerializationService {
  /// Serializes a list of [PWMConfig] objects into a little-endian byte array.
  /// 
  /// Each [PWMConfig] is treated as a 16-bit word (`addWord`).
  static Uint8List serializePwmConfigs(List<PWMConfig> configs) {
    final builder = BytesBuilder();

    for (final config in configs) {
      builder.addWord(config.rawValue, Endian.little);
    }

    return builder.toBytes();
  }

  /// Appends a 32-bit (DWord) identifier or sync word to the stream.
  static Uint8List appendSyncWord(Uint8List existingBytes, int syncWord) {
    final builder = BytesBuilder()
      ..add(existingBytes)
      ..addDWord(syncWord, Endian.little);
      
    return builder.toBytes();
  }
}
