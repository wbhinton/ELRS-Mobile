// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_definition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TargetDefinition {

/// Manufacturer/Vendor name (e.g., "HappyModel")
 String get vendor;/// Human-readble name (e.g., "HappyModel ES24TX 2.4GHz TX")
 String get name;/// Product code used for identification
@JsonKey(name: 'product_code') String? get productCode;/// Firmware target identifier
/// Note: This can be a String or nested object in some cases,
/// but for now we map it as a String if it exists.
 String? get firmware;/// Configuration map containing 'serial_rx', 'serial_tx', etc.
 Map<String, dynamic> get config;/// Target architecture platform (e.g., "esp8285", "esp32", "esp32-s3")
 String? get platform;// Keeping prior fields that might be useful, but making them optional/default to avoid breakages if not present
@JsonKey(name: 'upload_methods') List<String> get uploadMethods; List<String> get options; String get category;@JsonKey(name: 'device_type') String get deviceType;@JsonKey(name: 'frequency_type') String get frequencyType;@JsonKey(name: 'min_version') String? get minVersion;
/// Create a copy of TargetDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetDefinitionCopyWith<TargetDefinition> get copyWith => _$TargetDefinitionCopyWithImpl<TargetDefinition>(this as TargetDefinition, _$identity);

  /// Serializes this TargetDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetDefinition&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.name, name) || other.name == name)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.firmware, firmware) || other.firmware == firmware)&&const DeepCollectionEquality().equals(other.config, config)&&(identical(other.platform, platform) || other.platform == platform)&&const DeepCollectionEquality().equals(other.uploadMethods, uploadMethods)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.category, category) || other.category == category)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.frequencyType, frequencyType) || other.frequencyType == frequencyType)&&(identical(other.minVersion, minVersion) || other.minVersion == minVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vendor,name,productCode,firmware,const DeepCollectionEquality().hash(config),platform,const DeepCollectionEquality().hash(uploadMethods),const DeepCollectionEquality().hash(options),category,deviceType,frequencyType,minVersion);

@override
String toString() {
  return 'TargetDefinition(vendor: $vendor, name: $name, productCode: $productCode, firmware: $firmware, config: $config, platform: $platform, uploadMethods: $uploadMethods, options: $options, category: $category, deviceType: $deviceType, frequencyType: $frequencyType, minVersion: $minVersion)';
}


}

/// @nodoc
abstract mixin class $TargetDefinitionCopyWith<$Res>  {
  factory $TargetDefinitionCopyWith(TargetDefinition value, $Res Function(TargetDefinition) _then) = _$TargetDefinitionCopyWithImpl;
@useResult
$Res call({
 String vendor, String name,@JsonKey(name: 'product_code') String? productCode, String? firmware, Map<String, dynamic> config, String? platform,@JsonKey(name: 'upload_methods') List<String> uploadMethods, List<String> options, String category,@JsonKey(name: 'device_type') String deviceType,@JsonKey(name: 'frequency_type') String frequencyType,@JsonKey(name: 'min_version') String? minVersion
});




}
/// @nodoc
class _$TargetDefinitionCopyWithImpl<$Res>
    implements $TargetDefinitionCopyWith<$Res> {
  _$TargetDefinitionCopyWithImpl(this._self, this._then);

  final TargetDefinition _self;
  final $Res Function(TargetDefinition) _then;

/// Create a copy of TargetDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vendor = null,Object? name = null,Object? productCode = freezed,Object? firmware = freezed,Object? config = null,Object? platform = freezed,Object? uploadMethods = null,Object? options = null,Object? category = null,Object? deviceType = null,Object? frequencyType = null,Object? minVersion = freezed,}) {
  return _then(_self.copyWith(
vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String?,firmware: freezed == firmware ? _self.firmware : firmware // ignore: cast_nullable_to_non_nullable
as String?,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,uploadMethods: null == uploadMethods ? _self.uploadMethods : uploadMethods // ignore: cast_nullable_to_non_nullable
as List<String>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String,frequencyType: null == frequencyType ? _self.frequencyType : frequencyType // ignore: cast_nullable_to_non_nullable
as String,minVersion: freezed == minVersion ? _self.minVersion : minVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TargetDefinition].
extension TargetDefinitionPatterns on TargetDefinition {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TargetDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TargetDefinition() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TargetDefinition value)  $default,){
final _that = this;
switch (_that) {
case _TargetDefinition():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TargetDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _TargetDefinition() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String vendor,  String name, @JsonKey(name: 'product_code')  String? productCode,  String? firmware,  Map<String, dynamic> config,  String? platform, @JsonKey(name: 'upload_methods')  List<String> uploadMethods,  List<String> options,  String category, @JsonKey(name: 'device_type')  String deviceType, @JsonKey(name: 'frequency_type')  String frequencyType, @JsonKey(name: 'min_version')  String? minVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TargetDefinition() when $default != null:
return $default(_that.vendor,_that.name,_that.productCode,_that.firmware,_that.config,_that.platform,_that.uploadMethods,_that.options,_that.category,_that.deviceType,_that.frequencyType,_that.minVersion);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String vendor,  String name, @JsonKey(name: 'product_code')  String? productCode,  String? firmware,  Map<String, dynamic> config,  String? platform, @JsonKey(name: 'upload_methods')  List<String> uploadMethods,  List<String> options,  String category, @JsonKey(name: 'device_type')  String deviceType, @JsonKey(name: 'frequency_type')  String frequencyType, @JsonKey(name: 'min_version')  String? minVersion)  $default,) {final _that = this;
switch (_that) {
case _TargetDefinition():
return $default(_that.vendor,_that.name,_that.productCode,_that.firmware,_that.config,_that.platform,_that.uploadMethods,_that.options,_that.category,_that.deviceType,_that.frequencyType,_that.minVersion);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String vendor,  String name, @JsonKey(name: 'product_code')  String? productCode,  String? firmware,  Map<String, dynamic> config,  String? platform, @JsonKey(name: 'upload_methods')  List<String> uploadMethods,  List<String> options,  String category, @JsonKey(name: 'device_type')  String deviceType, @JsonKey(name: 'frequency_type')  String frequencyType, @JsonKey(name: 'min_version')  String? minVersion)?  $default,) {final _that = this;
switch (_that) {
case _TargetDefinition() when $default != null:
return $default(_that.vendor,_that.name,_that.productCode,_that.firmware,_that.config,_that.platform,_that.uploadMethods,_that.options,_that.category,_that.deviceType,_that.frequencyType,_that.minVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TargetDefinition extends TargetDefinition {
  const _TargetDefinition({required this.vendor, required this.name, @JsonKey(name: 'product_code') this.productCode, this.firmware, final  Map<String, dynamic> config = const {}, this.platform, @JsonKey(name: 'upload_methods') final  List<String> uploadMethods = const [], final  List<String> options = const [], this.category = '', @JsonKey(name: 'device_type') this.deviceType = 'RX', @JsonKey(name: 'frequency_type') this.frequencyType = '2.4GHz', @JsonKey(name: 'min_version') this.minVersion}): _config = config,_uploadMethods = uploadMethods,_options = options,super._();
  factory _TargetDefinition.fromJson(Map<String, dynamic> json) => _$TargetDefinitionFromJson(json);

/// Manufacturer/Vendor name (e.g., "HappyModel")
@override final  String vendor;
/// Human-readble name (e.g., "HappyModel ES24TX 2.4GHz TX")
@override final  String name;
/// Product code used for identification
@override@JsonKey(name: 'product_code') final  String? productCode;
/// Firmware target identifier
/// Note: This can be a String or nested object in some cases,
/// but for now we map it as a String if it exists.
@override final  String? firmware;
/// Configuration map containing 'serial_rx', 'serial_tx', etc.
 final  Map<String, dynamic> _config;
/// Configuration map containing 'serial_rx', 'serial_tx', etc.
@override@JsonKey() Map<String, dynamic> get config {
  if (_config is EqualUnmodifiableMapView) return _config;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_config);
}

/// Target architecture platform (e.g., "esp8285", "esp32", "esp32-s3")
@override final  String? platform;
// Keeping prior fields that might be useful, but making them optional/default to avoid breakages if not present
 final  List<String> _uploadMethods;
// Keeping prior fields that might be useful, but making them optional/default to avoid breakages if not present
@override@JsonKey(name: 'upload_methods') List<String> get uploadMethods {
  if (_uploadMethods is EqualUnmodifiableListView) return _uploadMethods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uploadMethods);
}

 final  List<String> _options;
@override@JsonKey() List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override@JsonKey() final  String category;
@override@JsonKey(name: 'device_type') final  String deviceType;
@override@JsonKey(name: 'frequency_type') final  String frequencyType;
@override@JsonKey(name: 'min_version') final  String? minVersion;

/// Create a copy of TargetDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TargetDefinitionCopyWith<_TargetDefinition> get copyWith => __$TargetDefinitionCopyWithImpl<_TargetDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TargetDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TargetDefinition&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.name, name) || other.name == name)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.firmware, firmware) || other.firmware == firmware)&&const DeepCollectionEquality().equals(other._config, _config)&&(identical(other.platform, platform) || other.platform == platform)&&const DeepCollectionEquality().equals(other._uploadMethods, _uploadMethods)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.category, category) || other.category == category)&&(identical(other.deviceType, deviceType) || other.deviceType == deviceType)&&(identical(other.frequencyType, frequencyType) || other.frequencyType == frequencyType)&&(identical(other.minVersion, minVersion) || other.minVersion == minVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vendor,name,productCode,firmware,const DeepCollectionEquality().hash(_config),platform,const DeepCollectionEquality().hash(_uploadMethods),const DeepCollectionEquality().hash(_options),category,deviceType,frequencyType,minVersion);

@override
String toString() {
  return 'TargetDefinition(vendor: $vendor, name: $name, productCode: $productCode, firmware: $firmware, config: $config, platform: $platform, uploadMethods: $uploadMethods, options: $options, category: $category, deviceType: $deviceType, frequencyType: $frequencyType, minVersion: $minVersion)';
}


}

/// @nodoc
abstract mixin class _$TargetDefinitionCopyWith<$Res> implements $TargetDefinitionCopyWith<$Res> {
  factory _$TargetDefinitionCopyWith(_TargetDefinition value, $Res Function(_TargetDefinition) _then) = __$TargetDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String vendor, String name,@JsonKey(name: 'product_code') String? productCode, String? firmware, Map<String, dynamic> config, String? platform,@JsonKey(name: 'upload_methods') List<String> uploadMethods, List<String> options, String category,@JsonKey(name: 'device_type') String deviceType,@JsonKey(name: 'frequency_type') String frequencyType,@JsonKey(name: 'min_version') String? minVersion
});




}
/// @nodoc
class __$TargetDefinitionCopyWithImpl<$Res>
    implements _$TargetDefinitionCopyWith<$Res> {
  __$TargetDefinitionCopyWithImpl(this._self, this._then);

  final _TargetDefinition _self;
  final $Res Function(_TargetDefinition) _then;

/// Create a copy of TargetDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vendor = null,Object? name = null,Object? productCode = freezed,Object? firmware = freezed,Object? config = null,Object? platform = freezed,Object? uploadMethods = null,Object? options = null,Object? category = null,Object? deviceType = null,Object? frequencyType = null,Object? minVersion = freezed,}) {
  return _then(_TargetDefinition(
vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String?,firmware: freezed == firmware ? _self.firmware : firmware // ignore: cast_nullable_to_non_nullable
as String?,config: null == config ? _self._config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,uploadMethods: null == uploadMethods ? _self._uploadMethods : uploadMethods // ignore: cast_nullable_to_non_nullable
as List<String>,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,deviceType: null == deviceType ? _self.deviceType : deviceType // ignore: cast_nullable_to_non_nullable
as String,frequencyType: null == frequencyType ? _self.frequencyType : frequencyType // ignore: cast_nullable_to_non_nullable
as String,minVersion: freezed == minVersion ? _self.minVersion : minVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
