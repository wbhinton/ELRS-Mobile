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
      settings: json['settings'] as Map<String, dynamic>? ?? const {},
      options: json['options'] as Map<String, dynamic>? ?? const {},
      config: json['config'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$RuntimeConfigToJson(_RuntimeConfig instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'version': instance.version,
      'target': instance.target,
      'activeIp': instance.activeIp,
      'settings': instance.settings,
      'options': instance.options,
      'config': instance.config,
    };
