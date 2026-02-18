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

/// Unique identifier for the firmware target (e.g., "HappyModel_ES24TX_2400_TX")
 String get firmware;/// Human-readble name (e.g., "HappyModel ES24TX 2.4GHz TX")
 String get name;/// Manufacturer/Vendor name (e.g., "HappyModel")
 String get vendor;/// Microcontroller unit (e.g., "ESP32", "ESP8285", "STM32")
 String get mcu;/// Product name used for identification
@JsonKey(name: 'product_name') String? get productName;/// Short name used in Lua scripts
@JsonKey(name: 'lua_name') String? get luaName;/// List of supported upload methods (e.g., "wifi", "uart", "betaflight_passthrough")
@JsonKey(name: 'upload_methods') List<String> get uploadMethods;/// List of build options/flags
 List<String> get options;/// Key-value pairs for pre-processor defines
 Map<String, dynamic> get defines;
/// Create a copy of TargetDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetDefinitionCopyWith<TargetDefinition> get copyWith => _$TargetDefinitionCopyWithImpl<TargetDefinition>(this as TargetDefinition, _$identity);

  /// Serializes this TargetDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetDefinition&&(identical(other.firmware, firmware) || other.firmware == firmware)&&(identical(other.name, name) || other.name == name)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.mcu, mcu) || other.mcu == mcu)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.luaName, luaName) || other.luaName == luaName)&&const DeepCollectionEquality().equals(other.uploadMethods, uploadMethods)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.defines, defines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firmware,name,vendor,mcu,productName,luaName,const DeepCollectionEquality().hash(uploadMethods),const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(defines));

@override
String toString() {
  return 'TargetDefinition(firmware: $firmware, name: $name, vendor: $vendor, mcu: $mcu, productName: $productName, luaName: $luaName, uploadMethods: $uploadMethods, options: $options, defines: $defines)';
}


}

/// @nodoc
abstract mixin class $TargetDefinitionCopyWith<$Res>  {
  factory $TargetDefinitionCopyWith(TargetDefinition value, $Res Function(TargetDefinition) _then) = _$TargetDefinitionCopyWithImpl;
@useResult
$Res call({
 String firmware, String name, String vendor, String mcu,@JsonKey(name: 'product_name') String? productName,@JsonKey(name: 'lua_name') String? luaName,@JsonKey(name: 'upload_methods') List<String> uploadMethods, List<String> options, Map<String, dynamic> defines
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
@pragma('vm:prefer-inline') @override $Res call({Object? firmware = null,Object? name = null,Object? vendor = null,Object? mcu = null,Object? productName = freezed,Object? luaName = freezed,Object? uploadMethods = null,Object? options = null,Object? defines = null,}) {
  return _then(_self.copyWith(
firmware: null == firmware ? _self.firmware : firmware // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,mcu: null == mcu ? _self.mcu : mcu // ignore: cast_nullable_to_non_nullable
as String,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,luaName: freezed == luaName ? _self.luaName : luaName // ignore: cast_nullable_to_non_nullable
as String?,uploadMethods: null == uploadMethods ? _self.uploadMethods : uploadMethods // ignore: cast_nullable_to_non_nullable
as List<String>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,defines: null == defines ? _self.defines : defines // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firmware,  String name,  String vendor,  String mcu, @JsonKey(name: 'product_name')  String? productName, @JsonKey(name: 'lua_name')  String? luaName, @JsonKey(name: 'upload_methods')  List<String> uploadMethods,  List<String> options,  Map<String, dynamic> defines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TargetDefinition() when $default != null:
return $default(_that.firmware,_that.name,_that.vendor,_that.mcu,_that.productName,_that.luaName,_that.uploadMethods,_that.options,_that.defines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firmware,  String name,  String vendor,  String mcu, @JsonKey(name: 'product_name')  String? productName, @JsonKey(name: 'lua_name')  String? luaName, @JsonKey(name: 'upload_methods')  List<String> uploadMethods,  List<String> options,  Map<String, dynamic> defines)  $default,) {final _that = this;
switch (_that) {
case _TargetDefinition():
return $default(_that.firmware,_that.name,_that.vendor,_that.mcu,_that.productName,_that.luaName,_that.uploadMethods,_that.options,_that.defines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firmware,  String name,  String vendor,  String mcu, @JsonKey(name: 'product_name')  String? productName, @JsonKey(name: 'lua_name')  String? luaName, @JsonKey(name: 'upload_methods')  List<String> uploadMethods,  List<String> options,  Map<String, dynamic> defines)?  $default,) {final _that = this;
switch (_that) {
case _TargetDefinition() when $default != null:
return $default(_that.firmware,_that.name,_that.vendor,_that.mcu,_that.productName,_that.luaName,_that.uploadMethods,_that.options,_that.defines);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TargetDefinition implements TargetDefinition {
  const _TargetDefinition({required this.firmware, required this.name, required this.vendor, required this.mcu, @JsonKey(name: 'product_name') this.productName, @JsonKey(name: 'lua_name') this.luaName, @JsonKey(name: 'upload_methods') final  List<String> uploadMethods = const [], final  List<String> options = const [], final  Map<String, dynamic> defines = const {}}): _uploadMethods = uploadMethods,_options = options,_defines = defines;
  factory _TargetDefinition.fromJson(Map<String, dynamic> json) => _$TargetDefinitionFromJson(json);

/// Unique identifier for the firmware target (e.g., "HappyModel_ES24TX_2400_TX")
@override final  String firmware;
/// Human-readble name (e.g., "HappyModel ES24TX 2.4GHz TX")
@override final  String name;
/// Manufacturer/Vendor name (e.g., "HappyModel")
@override final  String vendor;
/// Microcontroller unit (e.g., "ESP32", "ESP8285", "STM32")
@override final  String mcu;
/// Product name used for identification
@override@JsonKey(name: 'product_name') final  String? productName;
/// Short name used in Lua scripts
@override@JsonKey(name: 'lua_name') final  String? luaName;
/// List of supported upload methods (e.g., "wifi", "uart", "betaflight_passthrough")
 final  List<String> _uploadMethods;
/// List of supported upload methods (e.g., "wifi", "uart", "betaflight_passthrough")
@override@JsonKey(name: 'upload_methods') List<String> get uploadMethods {
  if (_uploadMethods is EqualUnmodifiableListView) return _uploadMethods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uploadMethods);
}

/// List of build options/flags
 final  List<String> _options;
/// List of build options/flags
@override@JsonKey() List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

/// Key-value pairs for pre-processor defines
 final  Map<String, dynamic> _defines;
/// Key-value pairs for pre-processor defines
@override@JsonKey() Map<String, dynamic> get defines {
  if (_defines is EqualUnmodifiableMapView) return _defines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_defines);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TargetDefinition&&(identical(other.firmware, firmware) || other.firmware == firmware)&&(identical(other.name, name) || other.name == name)&&(identical(other.vendor, vendor) || other.vendor == vendor)&&(identical(other.mcu, mcu) || other.mcu == mcu)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.luaName, luaName) || other.luaName == luaName)&&const DeepCollectionEquality().equals(other._uploadMethods, _uploadMethods)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._defines, _defines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firmware,name,vendor,mcu,productName,luaName,const DeepCollectionEquality().hash(_uploadMethods),const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_defines));

@override
String toString() {
  return 'TargetDefinition(firmware: $firmware, name: $name, vendor: $vendor, mcu: $mcu, productName: $productName, luaName: $luaName, uploadMethods: $uploadMethods, options: $options, defines: $defines)';
}


}

/// @nodoc
abstract mixin class _$TargetDefinitionCopyWith<$Res> implements $TargetDefinitionCopyWith<$Res> {
  factory _$TargetDefinitionCopyWith(_TargetDefinition value, $Res Function(_TargetDefinition) _then) = __$TargetDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String firmware, String name, String vendor, String mcu,@JsonKey(name: 'product_name') String? productName,@JsonKey(name: 'lua_name') String? luaName,@JsonKey(name: 'upload_methods') List<String> uploadMethods, List<String> options, Map<String, dynamic> defines
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
@override @pragma('vm:prefer-inline') $Res call({Object? firmware = null,Object? name = null,Object? vendor = null,Object? mcu = null,Object? productName = freezed,Object? luaName = freezed,Object? uploadMethods = null,Object? options = null,Object? defines = null,}) {
  return _then(_TargetDefinition(
firmware: null == firmware ? _self.firmware : firmware // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,vendor: null == vendor ? _self.vendor : vendor // ignore: cast_nullable_to_non_nullable
as String,mcu: null == mcu ? _self.mcu : mcu // ignore: cast_nullable_to_non_nullable
as String,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,luaName: freezed == luaName ? _self.luaName : luaName // ignore: cast_nullable_to_non_nullable
as String?,uploadMethods: null == uploadMethods ? _self._uploadMethods : uploadMethods // ignore: cast_nullable_to_non_nullable
as List<String>,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,defines: null == defines ? _self._defines : defines // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
