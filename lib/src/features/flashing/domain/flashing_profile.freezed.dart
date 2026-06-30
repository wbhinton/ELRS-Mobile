// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flashing_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FlashingProfile {

 String get id; String get name; String get bindPhrase; String get wifiSsid; String get wifiPassword; int get defaultDomain2400; int get defaultDomain900;
/// Create a copy of FlashingProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashingProfileCopyWith<FlashingProfile> get copyWith => _$FlashingProfileCopyWithImpl<FlashingProfile>(this as FlashingProfile, _$identity);

  /// Serializes this FlashingProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashingProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.bindPhrase, bindPhrase) || other.bindPhrase == bindPhrase)&&(identical(other.wifiSsid, wifiSsid) || other.wifiSsid == wifiSsid)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&(identical(other.defaultDomain2400, defaultDomain2400) || other.defaultDomain2400 == defaultDomain2400)&&(identical(other.defaultDomain900, defaultDomain900) || other.defaultDomain900 == defaultDomain900));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,bindPhrase,wifiSsid,wifiPassword,defaultDomain2400,defaultDomain900);

@override
String toString() {
  return 'FlashingProfile(id: $id, name: $name, bindPhrase: $bindPhrase, wifiSsid: $wifiSsid, wifiPassword: $wifiPassword, defaultDomain2400: $defaultDomain2400, defaultDomain900: $defaultDomain900)';
}


}

/// @nodoc
abstract mixin class $FlashingProfileCopyWith<$Res>  {
  factory $FlashingProfileCopyWith(FlashingProfile value, $Res Function(FlashingProfile) _then) = _$FlashingProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, String bindPhrase, String wifiSsid, String wifiPassword, int defaultDomain2400, int defaultDomain900
});




}
/// @nodoc
class _$FlashingProfileCopyWithImpl<$Res>
    implements $FlashingProfileCopyWith<$Res> {
  _$FlashingProfileCopyWithImpl(this._self, this._then);

  final FlashingProfile _self;
  final $Res Function(FlashingProfile) _then;

/// Create a copy of FlashingProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? bindPhrase = null,Object? wifiSsid = null,Object? wifiPassword = null,Object? defaultDomain2400 = null,Object? defaultDomain900 = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bindPhrase: null == bindPhrase ? _self.bindPhrase : bindPhrase // ignore: cast_nullable_to_non_nullable
as String,wifiSsid: null == wifiSsid ? _self.wifiSsid : wifiSsid // ignore: cast_nullable_to_non_nullable
as String,wifiPassword: null == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String,defaultDomain2400: null == defaultDomain2400 ? _self.defaultDomain2400 : defaultDomain2400 // ignore: cast_nullable_to_non_nullable
as int,defaultDomain900: null == defaultDomain900 ? _self.defaultDomain900 : defaultDomain900 // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FlashingProfile].
extension FlashingProfilePatterns on FlashingProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashingProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashingProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashingProfile value)  $default,){
final _that = this;
switch (_that) {
case _FlashingProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashingProfile value)?  $default,){
final _that = this;
switch (_that) {
case _FlashingProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String bindPhrase,  String wifiSsid,  String wifiPassword,  int defaultDomain2400,  int defaultDomain900)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashingProfile() when $default != null:
return $default(_that.id,_that.name,_that.bindPhrase,_that.wifiSsid,_that.wifiPassword,_that.defaultDomain2400,_that.defaultDomain900);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String bindPhrase,  String wifiSsid,  String wifiPassword,  int defaultDomain2400,  int defaultDomain900)  $default,) {final _that = this;
switch (_that) {
case _FlashingProfile():
return $default(_that.id,_that.name,_that.bindPhrase,_that.wifiSsid,_that.wifiPassword,_that.defaultDomain2400,_that.defaultDomain900);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String bindPhrase,  String wifiSsid,  String wifiPassword,  int defaultDomain2400,  int defaultDomain900)?  $default,) {final _that = this;
switch (_that) {
case _FlashingProfile() when $default != null:
return $default(_that.id,_that.name,_that.bindPhrase,_that.wifiSsid,_that.wifiPassword,_that.defaultDomain2400,_that.defaultDomain900);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlashingProfile implements FlashingProfile {
  const _FlashingProfile({required this.id, required this.name, this.bindPhrase = '', this.wifiSsid = '', this.wifiPassword = '', this.defaultDomain2400 = 0, this.defaultDomain900 = 1});
  factory _FlashingProfile.fromJson(Map<String, dynamic> json) => _$FlashingProfileFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String bindPhrase;
@override@JsonKey() final  String wifiSsid;
@override@JsonKey() final  String wifiPassword;
@override@JsonKey() final  int defaultDomain2400;
@override@JsonKey() final  int defaultDomain900;

/// Create a copy of FlashingProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashingProfileCopyWith<_FlashingProfile> get copyWith => __$FlashingProfileCopyWithImpl<_FlashingProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlashingProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashingProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.bindPhrase, bindPhrase) || other.bindPhrase == bindPhrase)&&(identical(other.wifiSsid, wifiSsid) || other.wifiSsid == wifiSsid)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&(identical(other.defaultDomain2400, defaultDomain2400) || other.defaultDomain2400 == defaultDomain2400)&&(identical(other.defaultDomain900, defaultDomain900) || other.defaultDomain900 == defaultDomain900));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,bindPhrase,wifiSsid,wifiPassword,defaultDomain2400,defaultDomain900);

@override
String toString() {
  return 'FlashingProfile(id: $id, name: $name, bindPhrase: $bindPhrase, wifiSsid: $wifiSsid, wifiPassword: $wifiPassword, defaultDomain2400: $defaultDomain2400, defaultDomain900: $defaultDomain900)';
}


}

/// @nodoc
abstract mixin class _$FlashingProfileCopyWith<$Res> implements $FlashingProfileCopyWith<$Res> {
  factory _$FlashingProfileCopyWith(_FlashingProfile value, $Res Function(_FlashingProfile) _then) = __$FlashingProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String bindPhrase, String wifiSsid, String wifiPassword, int defaultDomain2400, int defaultDomain900
});




}
/// @nodoc
class __$FlashingProfileCopyWithImpl<$Res>
    implements _$FlashingProfileCopyWith<$Res> {
  __$FlashingProfileCopyWithImpl(this._self, this._then);

  final _FlashingProfile _self;
  final $Res Function(_FlashingProfile) _then;

/// Create a copy of FlashingProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? bindPhrase = null,Object? wifiSsid = null,Object? wifiPassword = null,Object? defaultDomain2400 = null,Object? defaultDomain900 = null,}) {
  return _then(_FlashingProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bindPhrase: null == bindPhrase ? _self.bindPhrase : bindPhrase // ignore: cast_nullable_to_non_nullable
as String,wifiSsid: null == wifiSsid ? _self.wifiSsid : wifiSsid // ignore: cast_nullable_to_non_nullable
as String,wifiPassword: null == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String,defaultDomain2400: null == defaultDomain2400 ? _self.defaultDomain2400 : defaultDomain2400 // ignore: cast_nullable_to_non_nullable
as int,defaultDomain900: null == defaultDomain900 ? _self.defaultDomain900 : defaultDomain900 // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
