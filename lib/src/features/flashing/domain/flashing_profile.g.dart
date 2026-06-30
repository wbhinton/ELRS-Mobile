// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashing_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlashingProfile _$FlashingProfileFromJson(Map<String, dynamic> json) =>
    _FlashingProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      bindPhrase: json['bindPhrase'] as String? ?? '',
      wifiSsid: json['wifiSsid'] as String? ?? '',
      wifiPassword: json['wifiPassword'] as String? ?? '',
      defaultDomain2400: (json['defaultDomain2400'] as num?)?.toInt() ?? 0,
      defaultDomain900: (json['defaultDomain900'] as num?)?.toInt() ?? 1,
      wifiOnInterval: (json['wifiOnInterval'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$FlashingProfileToJson(_FlashingProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bindPhrase': instance.bindPhrase,
      'wifiSsid': instance.wifiSsid,
      'wifiPassword': instance.wifiPassword,
      'defaultDomain2400': instance.defaultDomain2400,
      'defaultDomain900': instance.defaultDomain900,
      'wifiOnInterval': instance.wifiOnInterval,
    };
