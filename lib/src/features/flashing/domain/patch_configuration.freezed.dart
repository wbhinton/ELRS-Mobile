// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patch_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PatchConfiguration {

 String get bindPhrase; String? get wifiSsid; String? get wifiPassword; int? get regulatoryDomain; int? get domain; int? get wifiOnInterval; List<int>? get uid;
/// Create a copy of PatchConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatchConfigurationCopyWith<PatchConfiguration> get copyWith => _$PatchConfigurationCopyWithImpl<PatchConfiguration>(this as PatchConfiguration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatchConfiguration&&(identical(other.bindPhrase, bindPhrase) || other.bindPhrase == bindPhrase)&&(identical(other.wifiSsid, wifiSsid) || other.wifiSsid == wifiSsid)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&(identical(other.regulatoryDomain, regulatoryDomain) || other.regulatoryDomain == regulatoryDomain)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.wifiOnInterval, wifiOnInterval) || other.wifiOnInterval == wifiOnInterval)&&const DeepCollectionEquality().equals(other.uid, uid));
}


@override
int get hashCode => Object.hash(runtimeType,bindPhrase,wifiSsid,wifiPassword,regulatoryDomain,domain,wifiOnInterval,const DeepCollectionEquality().hash(uid));

@override
String toString() {
  return 'PatchConfiguration(bindPhrase: $bindPhrase, wifiSsid: $wifiSsid, wifiPassword: $wifiPassword, regulatoryDomain: $regulatoryDomain, domain: $domain, wifiOnInterval: $wifiOnInterval, uid: $uid)';
}


}

/// @nodoc
abstract mixin class $PatchConfigurationCopyWith<$Res>  {
  factory $PatchConfigurationCopyWith(PatchConfiguration value, $Res Function(PatchConfiguration) _then) = _$PatchConfigurationCopyWithImpl;
@useResult
$Res call({
 String bindPhrase, String? wifiSsid, String? wifiPassword, int? regulatoryDomain, int? domain, int? wifiOnInterval, List<int>? uid
});




}
/// @nodoc
class _$PatchConfigurationCopyWithImpl<$Res>
    implements $PatchConfigurationCopyWith<$Res> {
  _$PatchConfigurationCopyWithImpl(this._self, this._then);

  final PatchConfiguration _self;
  final $Res Function(PatchConfiguration) _then;

/// Create a copy of PatchConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bindPhrase = null,Object? wifiSsid = freezed,Object? wifiPassword = freezed,Object? regulatoryDomain = freezed,Object? domain = freezed,Object? wifiOnInterval = freezed,Object? uid = freezed,}) {
  return _then(_self.copyWith(
bindPhrase: null == bindPhrase ? _self.bindPhrase : bindPhrase // ignore: cast_nullable_to_non_nullable
as String,wifiSsid: freezed == wifiSsid ? _self.wifiSsid : wifiSsid // ignore: cast_nullable_to_non_nullable
as String?,wifiPassword: freezed == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String?,regulatoryDomain: freezed == regulatoryDomain ? _self.regulatoryDomain : regulatoryDomain // ignore: cast_nullable_to_non_nullable
as int?,domain: freezed == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as int?,wifiOnInterval: freezed == wifiOnInterval ? _self.wifiOnInterval : wifiOnInterval // ignore: cast_nullable_to_non_nullable
as int?,uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PatchConfiguration].
extension PatchConfigurationPatterns on PatchConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatchConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatchConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatchConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _PatchConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatchConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _PatchConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bindPhrase,  String? wifiSsid,  String? wifiPassword,  int? regulatoryDomain,  int? domain,  int? wifiOnInterval,  List<int>? uid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatchConfiguration() when $default != null:
return $default(_that.bindPhrase,_that.wifiSsid,_that.wifiPassword,_that.regulatoryDomain,_that.domain,_that.wifiOnInterval,_that.uid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bindPhrase,  String? wifiSsid,  String? wifiPassword,  int? regulatoryDomain,  int? domain,  int? wifiOnInterval,  List<int>? uid)  $default,) {final _that = this;
switch (_that) {
case _PatchConfiguration():
return $default(_that.bindPhrase,_that.wifiSsid,_that.wifiPassword,_that.regulatoryDomain,_that.domain,_that.wifiOnInterval,_that.uid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bindPhrase,  String? wifiSsid,  String? wifiPassword,  int? regulatoryDomain,  int? domain,  int? wifiOnInterval,  List<int>? uid)?  $default,) {final _that = this;
switch (_that) {
case _PatchConfiguration() when $default != null:
return $default(_that.bindPhrase,_that.wifiSsid,_that.wifiPassword,_that.regulatoryDomain,_that.domain,_that.wifiOnInterval,_that.uid);case _:
  return null;

}
}

}

/// @nodoc


class _PatchConfiguration implements PatchConfiguration {
  const _PatchConfiguration({required this.bindPhrase, this.wifiSsid, this.wifiPassword, this.regulatoryDomain, this.domain, this.wifiOnInterval, final  List<int>? uid}): _uid = uid;
  

@override final  String bindPhrase;
@override final  String? wifiSsid;
@override final  String? wifiPassword;
@override final  int? regulatoryDomain;
@override final  int? domain;
@override final  int? wifiOnInterval;
 final  List<int>? _uid;
@override List<int>? get uid {
  final value = _uid;
  if (value == null) return null;
  if (_uid is EqualUnmodifiableListView) return _uid;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PatchConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatchConfigurationCopyWith<_PatchConfiguration> get copyWith => __$PatchConfigurationCopyWithImpl<_PatchConfiguration>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatchConfiguration&&(identical(other.bindPhrase, bindPhrase) || other.bindPhrase == bindPhrase)&&(identical(other.wifiSsid, wifiSsid) || other.wifiSsid == wifiSsid)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&(identical(other.regulatoryDomain, regulatoryDomain) || other.regulatoryDomain == regulatoryDomain)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.wifiOnInterval, wifiOnInterval) || other.wifiOnInterval == wifiOnInterval)&&const DeepCollectionEquality().equals(other._uid, _uid));
}


@override
int get hashCode => Object.hash(runtimeType,bindPhrase,wifiSsid,wifiPassword,regulatoryDomain,domain,wifiOnInterval,const DeepCollectionEquality().hash(_uid));

@override
String toString() {
  return 'PatchConfiguration(bindPhrase: $bindPhrase, wifiSsid: $wifiSsid, wifiPassword: $wifiPassword, regulatoryDomain: $regulatoryDomain, domain: $domain, wifiOnInterval: $wifiOnInterval, uid: $uid)';
}


}

/// @nodoc
abstract mixin class _$PatchConfigurationCopyWith<$Res> implements $PatchConfigurationCopyWith<$Res> {
  factory _$PatchConfigurationCopyWith(_PatchConfiguration value, $Res Function(_PatchConfiguration) _then) = __$PatchConfigurationCopyWithImpl;
@override @useResult
$Res call({
 String bindPhrase, String? wifiSsid, String? wifiPassword, int? regulatoryDomain, int? domain, int? wifiOnInterval, List<int>? uid
});




}
/// @nodoc
class __$PatchConfigurationCopyWithImpl<$Res>
    implements _$PatchConfigurationCopyWith<$Res> {
  __$PatchConfigurationCopyWithImpl(this._self, this._then);

  final _PatchConfiguration _self;
  final $Res Function(_PatchConfiguration) _then;

/// Create a copy of PatchConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bindPhrase = null,Object? wifiSsid = freezed,Object? wifiPassword = freezed,Object? regulatoryDomain = freezed,Object? domain = freezed,Object? wifiOnInterval = freezed,Object? uid = freezed,}) {
  return _then(_PatchConfiguration(
bindPhrase: null == bindPhrase ? _self.bindPhrase : bindPhrase // ignore: cast_nullable_to_non_nullable
as String,wifiSsid: freezed == wifiSsid ? _self.wifiSsid : wifiSsid // ignore: cast_nullable_to_non_nullable
as String?,wifiPassword: freezed == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String?,regulatoryDomain: freezed == regulatoryDomain ? _self.regulatoryDomain : regulatoryDomain // ignore: cast_nullable_to_non_nullable
as int?,domain: freezed == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as int?,wifiOnInterval: freezed == wifiOnInterval ? _self.wifiOnInterval : wifiOnInterval // ignore: cast_nullable_to_non_nullable
as int?,uid: freezed == uid ? _self._uid : uid // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

// dart format on
