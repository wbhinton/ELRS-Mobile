import 'package:freezed_annotation/freezed_annotation.dart';

part 'runtime_config_model.freezed.dart';
part 'runtime_config_model.g.dart';

@freezed
abstract class RuntimeConfig with _$RuntimeConfig {
  @JsonSerializable(explicitToJson: true)
  const factory RuntimeConfig({
    @JsonKey(name: 'product_name') String? productName,
    @Default('unknown') String version,
    String? target,
    String? activeIp,
    @Default(ElrsSettings()) ElrsSettings settings,
    @Default(ElrsOptions()) ElrsOptions options,
    @Default(ElrsConfig()) ElrsConfig config,
  }) = _RuntimeConfig;

  factory RuntimeConfig.fromJson(Map<String, dynamic> json) =>
      _$RuntimeConfigFromJson(json);
}

@freezed
abstract class ElrsSettings with _$ElrsSettings {
  @JsonSerializable(explicitToJson: true)
  const factory ElrsSettings({
    @JsonKey(name: 'product_name') String? productName,
    String? version,
    String? target,
    @JsonKey(name: 'module-type') String? moduleType,
    @JsonKey(name: 'has_serial_pins') bool? hasSerialPins,
  }) = _ElrsSettings;

  factory ElrsSettings.fromJson(Map<String, dynamic> json) =>
      _$ElrsSettingsFromJson(json);
}

@freezed
abstract class ElrsOptions with _$ElrsOptions {
  @JsonSerializable(explicitToJson: true)
  const factory ElrsOptions({
    List<int>? uid,
    @JsonKey(name: 'wifi-ssid') String? wifiSsid,
    @JsonKey(name: 'wifi-password') String? wifiPassword,
    @JsonKey(name: 'wifi-on-interval') int? wifiOnInterval,
    @JsonKey(name: 'is-airport') bool? isAirport,
    @JsonKey(name: 'airport-uart-baud') int? airportUartBaud,
    @JsonKey(name: 'tlm-interval') int? tlmInterval,
    @JsonKey(name: 'fan-runtime') int? fanRuntime,
    @JsonKey(name: 'lock-on-first-connection') bool? lockOnFirstConnection,
    @JsonKey(name: 'rcvr-uart-baud') int? rcvrUartBaud,
    @JsonKey(name: 'dji-permanently-armed') bool? djiPermanentlyArmed,
    int? domain,
  }) = _ElrsOptions;

  factory ElrsOptions.fromJson(Map<String, dynamic> json) =>
      _$ElrsOptionsFromJson(json);
}

@freezed
abstract class ElrsConfig with _$ElrsConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ElrsConfig({
    @JsonKey(name: 'modelid') int? modelId,
    @JsonKey(name: 'force-tlm') bool? forceTlm,
    int? vbind,
    @JsonKey(name: 'serial-protocol') int? serialProtocol,
    @JsonKey(name: 'serial1-protocol') int? serial1Protocol,
    @JsonKey(name: 'sbus-failsafe') int? sbusFailsafe,
    @Default([]) List<dynamic> pwm,
    Map<String, dynamic>? hardware,
  }) = _ElrsConfig;

  factory ElrsConfig.fromJson(Map<String, dynamic> json) =>
      _$ElrsConfigFromJson(json);
}
