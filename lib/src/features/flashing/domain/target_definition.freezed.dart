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
 List<String> get upload_methods; List<String> get options;
/// Create a copy of TargetDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetDefinitionCopyWith<TargetDefinition> get copyWith => _$TargetDefinitionCopyWithImpl<TargetDefinition>(this as TargetDefinition, _$identity);

  /// Serializes this TargetDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetDefinition&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.name, name) || other.name == name)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.firmware, firmware) || other.firmware == firmware)&&const DeepCollectionEquality().equals(other.config, config)&&(identical(other.platform, platform) || other.platform == platform)&&const DeepCollectionEquality().equals(other.upload_methods, upload_methods)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vendor,name,productCode,firmware,const DeepCollectionEquality().hash(config),platform,const DeepCollectionEquality().hash(upload_methods),const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'TargetDefinition(vendor: $vendor, name: $name, productCode: $productCode, firmware: $firmware, config: $config, platform: $platform, upload_methods: $upload_methods, options: $options)';
}


}

/// @nodoc
abstract mixin class $TargetDefinitionCopyWith<$Res>  {
  factory $TargetDefinitionCopyWith(TargetDefinition value, $Res Function(TargetDefinition) _then) = _$TargetDefinitionCopyWithImpl;
@useResult
$Res call({
 String vendor, String name,@JsonKey(name: 'product_code') String? productCode, String? firmware, Map<String, dynamic> config, String? platform, List<String> upload_methods, List<String> options
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
@pragma('vm:prefer-inline') @override $Res call({Object? vendor = null,Object? name = null,Object? productCode = freezed,Object? firmware = freezed,Object? config = null,Object? platform = freezed,Object? upload_methods = null,Object? options = null,}) {
  return _then(_self.copyWith(
vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String?,firmware: freezed == firmware ? _self.firmware : firmware // ignore: cast_nullable_to_non_nullable
as String?,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,upload_methods: null == upload_methods ? _self.upload_methods : upload_methods // ignore: cast_nullable_to_non_nullable
as List<String>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String vendor,  String name, @JsonKey(name: 'product_code')  String? productCode,  String? firmware,  Map<String, dynamic> config,  String? platform,  List<String> upload_methods,  List<String> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TargetDefinition() when $default != null:
return $default(_that.vendor,_that.name,_that.productCode,_that.firmware,_that.config,_that.platform,_that.upload_methods,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String vendor,  String name, @JsonKey(name: 'product_code')  String? productCode,  String? firmware,  Map<String, dynamic> config,  String? platform,  List<String> upload_methods,  List<String> options)  $default,) {final _that = this;
switch (_that) {
case _TargetDefinition():
return $default(_that.vendor,_that.name,_that.productCode,_that.firmware,_that.config,_that.platform,_that.upload_methods,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String vendor,  String name, @JsonKey(name: 'product_code')  String? productCode,  String? firmware,  Map<String, dynamic> config,  String? platform,  List<String> upload_methods,  List<String> options)?  $default,) {final _that = this;
switch (_that) {
case _TargetDefinition() when $default != null:
return $default(_that.vendor,_that.name,_that.productCode,_that.firmware,_that.config,_that.platform,_that.upload_methods,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TargetDefinition implements TargetDefinition {
  const _TargetDefinition({required this.vendor, required this.name, @JsonKey(name: 'product_code') this.productCode, this.firmware, final  Map<String, dynamic> config = const {}, this.platform, final  List<String> upload_methods = const [], final  List<String> options = const []}): _config = config,_upload_methods = upload_methods,_options = options;
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
 final  List<String> _upload_methods;
// Keeping prior fields that might be useful, but making them optional/default to avoid breakages if not present
@override@JsonKey() List<String> get upload_methods {
  if (_upload_methods is EqualUnmodifiableListView) return _upload_methods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upload_methods);
}

 final  List<String> _options;
@override@JsonKey() List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TargetDefinition&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.name, name) || other.name == name)&&(identical(other.productCode, productCode) || other.productCode == productCode)&&(identical(other.firmware, firmware) || other.firmware == firmware)&&const DeepCollectionEquality().equals(other._config, _config)&&(identical(other.platform, platform) || other.platform == platform)&&const DeepCollectionEquality().equals(other._upload_methods, _upload_methods)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vendor,name,productCode,firmware,const DeepCollectionEquality().hash(_config),platform,const DeepCollectionEquality().hash(_upload_methods),const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'TargetDefinition(vendor: $vendor, name: $name, productCode: $productCode, firmware: $firmware, config: $config, platform: $platform, upload_methods: $upload_methods, options: $options)';
}


}

/// @nodoc
abstract mixin class _$TargetDefinitionCopyWith<$Res> implements $TargetDefinitionCopyWith<$Res> {
  factory _$TargetDefinitionCopyWith(_TargetDefinition value, $Res Function(_TargetDefinition) _then) = __$TargetDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String vendor, String name,@JsonKey(name: 'product_code') String? productCode, String? firmware, Map<String, dynamic> config, String? platform, List<String> upload_methods, List<String> options
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
@override @pragma('vm:prefer-inline') $Res call({Object? vendor = null,Object? name = null,Object? productCode = freezed,Object? firmware = freezed,Object? config = null,Object? platform = freezed,Object? upload_methods = null,Object? options = null,}) {
  return _then(_TargetDefinition(
vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,productCode: freezed == productCode ? _self.productCode : productCode // ignore: cast_nullable_to_non_nullable
as String?,firmware: freezed == firmware ? _self.firmware : firmware // ignore: cast_nullable_to_non_nullable
as String?,config: null == config ? _self._config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,upload_methods: null == upload_methods ? _self._upload_methods : upload_methods // ignore: cast_nullable_to_non_nullable
as List<String>,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
