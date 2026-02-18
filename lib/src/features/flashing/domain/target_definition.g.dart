// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TargetDefinition _$TargetDefinitionFromJson(Map<String, dynamic> json) =>
    _TargetDefinition(
      firmware: json['firmware'] as String,
      name: json['name'] as String,
      vendor: json['vendor'] as String,
      mcu: json['mcu'] as String,
      productName: json['product_name'] as String?,
      luaName: json['lua_name'] as String?,
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
      defines: json['defines'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$TargetDefinitionToJson(_TargetDefinition instance) =>
    <String, dynamic>{
      'firmware': instance.firmware,
      'name': instance.name,
      'vendor': instance.vendor,
      'mcu': instance.mcu,
      'product_name': instance.productName,
      'lua_name': instance.luaName,
      'upload_methods': instance.uploadMethods,
      'options': instance.options,
      'defines': instance.defines,
    };
