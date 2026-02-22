import 'package:binary/binary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../utils/frequency_validator.dart';

part 'runtime_config_model.freezed.dart';
part 'runtime_config_model.g.dart';

@freezed
abstract class RuntimeConfig with _$RuntimeConfig {
  // Required by freezed for extensions that define methods/getters on this class.
  // Without this, the generated _RuntimeConfig subclass does not forward calls
  // to extensions, causing NoSuchMethodError at runtime.
  const RuntimeConfig._();

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
    @JsonKey(name: 'device_id') int? deviceId,
    int? domain,
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
    @JsonKey(name: 'freq-index') int? freqIndex,
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

extension RuntimeConfigX on RuntimeConfig {
  /// Returns the active frequency band in MHz (900 or 2400).
  ///
  /// Uses bit 7 of [ElrsConfig.modelId] as the authoritative hardware
  /// capability flag — the same source the device's own WebUI reads.
  ///
  /// [freqIndex] is a *domain-list index* within the active band, not a
  /// band selector, so mapping it to MHz and validating against modelId
  /// produces spurious throws when the device has not yet set freqIndex
  /// (it defaults to 0 regardless of band).
  ///
  /// Use [FrequencyValidator.getValidatedFrequency] explicitly on the
  /// write-path (e.g. before saving settings) where strict enforcement
  /// is appropriate.
  int get frequencyBand {
    final rawModelId = config.modelId ?? 0;
    // Bit 7 of modelId is the 2.4 GHz capability flag (ground truth).
    final is2G4 = Uint16(rawModelId).nthBit(7);
    return is2G4 ? 2400 : 900;
  }
}
