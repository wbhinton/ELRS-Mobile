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
      upload_methods:
          (json['upload_methods'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TargetDefinitionToJson(_TargetDefinition instance) =>
    <String, dynamic>{
      'vendor': instance.vendor,
      'name': instance.name,
      'product_code': instance.productCode,
      'firmware': instance.firmware,
      'config': instance.config,
      'platform': instance.platform,
      'upload_methods': instance.upload_methods,
      'options': instance.options,
    };
