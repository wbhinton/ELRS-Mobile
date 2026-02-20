import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_definition.freezed.dart';
part 'target_definition.g.dart';

@freezed
abstract class TargetDefinition with _$TargetDefinition {
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
    @Default([]) List<String> upload_methods,
    @Default([]) List<String> options,
  }) = _TargetDefinition;

  factory TargetDefinition.fromJson(Map<String, dynamic> json) =>
      _$TargetDefinitionFromJson(json);
}
