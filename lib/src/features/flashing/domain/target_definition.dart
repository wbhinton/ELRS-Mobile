import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_definition.freezed.dart';
part 'target_definition.g.dart';

/*
  Example targets.json structure:
  {
    "firmware": "HappyModel_ES24TX_2400_TX",
    "name": "HappyModel ES24TX 2.4GHz TX",
    "vendor": "HappyModel",
    "mcu": "ESP32",
    "product_name": "ES24TX 2400 TX",
    "lua_name": "HM ES24TX",
    "upload_methods": ["wifi", "uart", "stlink"],
    "options": [
      "Regulatory_Domain_ISM_2400",
      "Extra_Button"
    ],
    "defines": {
      "MY_DEFINE": "VALUE"
    }
  }
*/

@freezed
class TargetDefinition with _$TargetDefinition {
  const factory TargetDefinition({
    /// Unique identifier for the firmware target (e.g., "HappyModel_ES24TX_2400_TX")
    required String firmware,

    /// Human-readble name (e.g., "HappyModel ES24TX 2.4GHz TX")
    required String name,

    /// Manufacturer/Vendor name (e.g., "HappyModel")
    required String vendor,

    /// Microcontroller unit (e.g., "ESP32", "ESP8285", "STM32")
    required String mcu,

    /// Product name used for identification
    @JsonKey(name: 'product_name') String? productName,

    /// Short name used in Lua scripts
    @JsonKey(name: 'lua_name') String? luaName,

    /// List of supported upload methods (e.g., "wifi", "uart", "betaflight_passthrough")
    @JsonKey(name: 'upload_methods') @Default([]) List<String> uploadMethods,

    /// List of build options/flags
    @Default([]) List<String> options,

    /// Key-value pairs for pre-processor defines
    @Default({}) Map<String, dynamic> defines,
  }) = _TargetDefinition;

  factory TargetDefinition.fromJson(Map<String, dynamic> json) =>
      _$TargetDefinitionFromJson(json);
}
