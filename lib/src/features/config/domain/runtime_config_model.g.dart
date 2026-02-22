// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'runtime_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RuntimeConfig _$RuntimeConfigFromJson(Map<String, dynamic> json) =>
    _RuntimeConfig(
      productName: json['product_name'] as String?,
      version: json['version'] as String? ?? 'unknown',
      target: json['target'] as String?,
      activeIp: json['activeIp'] as String?,
      settings: json['settings'] == null
          ? const ElrsSettings()
          : ElrsSettings.fromJson(json['settings'] as Map<String, dynamic>),
      options: json['options'] == null
          ? const ElrsOptions()
          : ElrsOptions.fromJson(json['options'] as Map<String, dynamic>),
      config: json['config'] == null
          ? const ElrsConfig()
          : ElrsConfig.fromJson(json['config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RuntimeConfigToJson(_RuntimeConfig instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'version': instance.version,
      'target': instance.target,
      'activeIp': instance.activeIp,
      'settings': instance.settings.toJson(),
      'options': instance.options.toJson(),
      'config': instance.config.toJson(),
    };

_ElrsSettings _$ElrsSettingsFromJson(Map<String, dynamic> json) =>
    _ElrsSettings(
      productName: json['product_name'] as String?,
      version: json['version'] as String?,
      target: json['target'] as String?,
      moduleType: json['module-type'] as String?,
      hasSerialPins: json['has_serial_pins'] as bool?,
      deviceId: (json['device_id'] as num?)?.toInt(),
      domain: (json['domain'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ElrsSettingsToJson(_ElrsSettings instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'version': instance.version,
      'target': instance.target,
      'module-type': instance.moduleType,
      'has_serial_pins': instance.hasSerialPins,
      'device_id': instance.deviceId,
      'domain': instance.domain,
    };

_ElrsOptions _$ElrsOptionsFromJson(Map<String, dynamic> json) => _ElrsOptions(
  uid: (json['uid'] as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
  wifiSsid: json['wifi-ssid'] as String?,
  wifiPassword: json['wifi-password'] as String?,
  wifiOnInterval: (json['wifi-on-interval'] as num?)?.toInt(),
  isAirport: json['is-airport'] as bool?,
  airportUartBaud: (json['airport-uart-baud'] as num?)?.toInt(),
  tlmInterval: (json['tlm-interval'] as num?)?.toInt(),
  fanRuntime: (json['fan-runtime'] as num?)?.toInt(),
  lockOnFirstConnection: json['lock-on-first-connection'] as bool?,
  rcvrUartBaud: (json['rcvr-uart-baud'] as num?)?.toInt(),
  djiPermanentlyArmed: json['dji-permanently-armed'] as bool?,
  freqIndex: (json['freq-index'] as num?)?.toInt(),
  domain: (json['domain'] as num?)?.toInt(),
);

Map<String, dynamic> _$ElrsOptionsToJson(_ElrsOptions instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'wifi-ssid': instance.wifiSsid,
      'wifi-password': instance.wifiPassword,
      'wifi-on-interval': instance.wifiOnInterval,
      'is-airport': instance.isAirport,
      'airport-uart-baud': instance.airportUartBaud,
      'tlm-interval': instance.tlmInterval,
      'fan-runtime': instance.fanRuntime,
      'lock-on-first-connection': instance.lockOnFirstConnection,
      'rcvr-uart-baud': instance.rcvrUartBaud,
      'dji-permanently-armed': instance.djiPermanentlyArmed,
      'freq-index': instance.freqIndex,
      'domain': instance.domain,
    };

_ElrsConfig _$ElrsConfigFromJson(Map<String, dynamic> json) => _ElrsConfig(
  modelId: (json['modelid'] as num?)?.toInt(),
  forceTlm: json['force-tlm'] as bool?,
  vbind: (json['vbind'] as num?)?.toInt(),
  serialProtocol: (json['serial-protocol'] as num?)?.toInt(),
  serial1Protocol: (json['serial1-protocol'] as num?)?.toInt(),
  sbusFailsafe: (json['sbus-failsafe'] as num?)?.toInt(),
  pwm: json['pwm'] as List<dynamic>? ?? const [],
  hardware: json['hardware'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ElrsConfigToJson(_ElrsConfig instance) =>
    <String, dynamic>{
      'modelid': instance.modelId,
      'force-tlm': instance.forceTlm,
      'vbind': instance.vbind,
      'serial-protocol': instance.serialProtocol,
      'serial1-protocol': instance.serial1Protocol,
      'sbus-failsafe': instance.sbusFailsafe,
      'pwm': instance.pwm,
      'hardware': instance.hardware,
    };
