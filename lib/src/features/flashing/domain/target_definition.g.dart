// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TargetDefinition _$TargetDefinitionFromJson(Map<String, dynamic> json) =>
    _TargetDefinition(
      vendor: json['vendor'] as String,
      name: json['name'] as String,
      productCode: json['product_code'] as String?,
      firmware: json['firmware'] as String?,
      config: json['config'] as Map<String, dynamic>? ?? const {},
      platform: json['platform'] as String?,
      uploadMethods:
          (json['upload_methods'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      category: json['category'] as String? ?? '',
      deviceType: json['device_type'] as String? ?? 'RX',
      frequencyType: json['frequency_type'] as String? ?? '2.4GHz',
    );

Map<String, dynamic> _$TargetDefinitionToJson(_TargetDefinition instance) =>
    <String, dynamic>{
      'vendor': instance.vendor,
      'name': instance.name,
      'product_code': instance.productCode,
      'firmware': instance.firmware,
      'config': instance.config,
      'platform': instance.platform,
      'upload_methods': instance.uploadMethods,
      'options': instance.options,
      'category': instance.category,
      'device_type': instance.deviceType,
      'frequency_type': instance.frequencyType,
    };
