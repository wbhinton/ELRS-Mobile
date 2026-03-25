import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_definition.freezed.dart';
part 'target_definition.g.dart';

@freezed
abstract class TargetDefinition with _$TargetDefinition {
  bool get isDualBand => frequencyType == 'Dual Band';
  bool get is900Mhz => frequencyType == '900MHz';
  bool get is2400Mhz => frequencyType == '2.4GHz';

  const TargetDefinition._();

  const factory TargetDefinition({
    /// Manufacturer/Vendor name (e.g., "HappyModel")
    required String vendor,

    /// Human-readble name (e.g., "HappyModel ES24TX 2.4GHz TX")
    required String name,

    /// Product code used for identification
    @JsonKey(name: 'product_code') String? productCode,

    /// Firmware target identifier
    /// Note: This can be a String or nested object in some cases,
    /// but for now we map it as a String if it exists.
    String? firmware,

    /// Configuration map containing 'serial_rx', 'serial_tx', etc.
    @Default({}) Map<String, dynamic> config,

    /// Target architecture platform (e.g., "esp8285", "esp32", "esp32-s3")
    String? platform,

    // Keeping prior fields that might be useful, but making them optional/default to avoid breakages if not present
    @JsonKey(name: 'upload_methods') @Default([]) List<String> uploadMethods,
    @Default([]) List<String> options,
    @Default('') String category,

    @JsonKey(name: 'device_type') @Default('RX') String deviceType,
    @JsonKey(name: 'frequency_type') @Default('2.4GHz') String frequencyType,
    @JsonKey(name: 'min_version') String? minVersion,
  }) = _TargetDefinition;

  factory TargetDefinition.fromJson(Map<String, dynamic> json) =>
      _$TargetDefinitionFromJson(json);
}
