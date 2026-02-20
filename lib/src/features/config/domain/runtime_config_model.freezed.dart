// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'runtime_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RuntimeConfig {

@JsonKey(name: 'product_name') String? get productName; String get version; String? get target; String? get activeIp; Map<String, dynamic> get settings; Map<String, dynamic> get options; Map<String, dynamic> get config;
/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuntimeConfigCopyWith<RuntimeConfig> get copyWith => _$RuntimeConfigCopyWithImpl<RuntimeConfig>(this as RuntimeConfig, _$identity);

  /// Serializes this RuntimeConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuntimeConfig&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.version, version) || other.version == version)&&(identical(other.target, target) || other.target == target)&&(identical(other.activeIp, activeIp) || other.activeIp == activeIp)&&const DeepCollectionEquality().equals(other.settings, settings)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.config, config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,version,target,activeIp,const DeepCollectionEquality().hash(settings),const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(config));

@override
String toString() {
  return 'RuntimeConfig(productName: $productName, version: $version, target: $target, activeIp: $activeIp, settings: $settings, options: $options, config: $config)';
}


}

/// @nodoc
abstract mixin class $RuntimeConfigCopyWith<$Res>  {
  factory $RuntimeConfigCopyWith(RuntimeConfig value, $Res Function(RuntimeConfig) _then) = _$RuntimeConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'product_name') String? productName, String version, String? target, String? activeIp, Map<String, dynamic> settings, Map<String, dynamic> options, Map<String, dynamic> config
});




}
/// @nodoc
class _$RuntimeConfigCopyWithImpl<$Res>
    implements $RuntimeConfigCopyWith<$Res> {
  _$RuntimeConfigCopyWithImpl(this._self, this._then);

  final RuntimeConfig _self;
  final $Res Function(RuntimeConfig) _then;

/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productName = freezed,Object? version = null,Object? target = freezed,Object? activeIp = freezed,Object? settings = null,Object? options = null,Object? config = null,}) {
  return _then(_self.copyWith(
productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String?,activeIp: freezed == activeIp ? _self.activeIp : activeIp // ignore: cast_nullable_to_non_nullable
as String?,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [RuntimeConfig].
extension RuntimeConfigPatterns on RuntimeConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuntimeConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuntimeConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuntimeConfig value)  $default,){
final _that = this;
switch (_that) {
case _RuntimeConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuntimeConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RuntimeConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_name')  String? productName,  String version,  String? target,  String? activeIp,  Map<String, dynamic> settings,  Map<String, dynamic> options,  Map<String, dynamic> config)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuntimeConfig() when $default != null:
return $default(_that.productName,_that.version,_that.target,_that.activeIp,_that.settings,_that.options,_that.config);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_name')  String? productName,  String version,  String? target,  String? activeIp,  Map<String, dynamic> settings,  Map<String, dynamic> options,  Map<String, dynamic> config)  $default,) {final _that = this;
switch (_that) {
case _RuntimeConfig():
return $default(_that.productName,_that.version,_that.target,_that.activeIp,_that.settings,_that.options,_that.config);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'product_name')  String? productName,  String version,  String? target,  String? activeIp,  Map<String, dynamic> settings,  Map<String, dynamic> options,  Map<String, dynamic> config)?  $default,) {final _that = this;
switch (_that) {
case _RuntimeConfig() when $default != null:
return $default(_that.productName,_that.version,_that.target,_that.activeIp,_that.settings,_that.options,_that.config);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RuntimeConfig implements RuntimeConfig {
  const _RuntimeConfig({@JsonKey(name: 'product_name') this.productName, this.version = 'unknown', this.target, this.activeIp, final  Map<String, dynamic> settings = const {}, final  Map<String, dynamic> options = const {}, final  Map<String, dynamic> config = const {}}): _settings = settings,_options = options,_config = config;
  factory _RuntimeConfig.fromJson(Map<String, dynamic> json) => _$RuntimeConfigFromJson(json);

@override@JsonKey(name: 'product_name') final  String? productName;
@override@JsonKey() final  String version;
@override final  String? target;
@override final  String? activeIp;
 final  Map<String, dynamic> _settings;
@override@JsonKey() Map<String, dynamic> get settings {
  if (_settings is EqualUnmodifiableMapView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_settings);
}

 final  Map<String, dynamic> _options;
@override@JsonKey() Map<String, dynamic> get options {
  if (_options is EqualUnmodifiableMapView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_options);
}

 final  Map<String, dynamic> _config;
@override@JsonKey() Map<String, dynamic> get config {
  if (_config is EqualUnmodifiableMapView) return _config;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_config);
}


/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuntimeConfigCopyWith<_RuntimeConfig> get copyWith => __$RuntimeConfigCopyWithImpl<_RuntimeConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RuntimeConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuntimeConfig&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.version, version) || other.version == version)&&(identical(other.target, target) || other.target == target)&&(identical(other.activeIp, activeIp) || other.activeIp == activeIp)&&const DeepCollectionEquality().equals(other._settings, _settings)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._config, _config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,version,target,activeIp,const DeepCollectionEquality().hash(_settings),const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_config));

@override
String toString() {
  return 'RuntimeConfig(productName: $productName, version: $version, target: $target, activeIp: $activeIp, settings: $settings, options: $options, config: $config)';
}


}

/// @nodoc
abstract mixin class _$RuntimeConfigCopyWith<$Res> implements $RuntimeConfigCopyWith<$Res> {
  factory _$RuntimeConfigCopyWith(_RuntimeConfig value, $Res Function(_RuntimeConfig) _then) = __$RuntimeConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'product_name') String? productName, String version, String? target, String? activeIp, Map<String, dynamic> settings, Map<String, dynamic> options, Map<String, dynamic> config
});




}
/// @nodoc
class __$RuntimeConfigCopyWithImpl<$Res>
    implements _$RuntimeConfigCopyWith<$Res> {
  __$RuntimeConfigCopyWithImpl(this._self, this._then);

  final _RuntimeConfig _self;
  final $Res Function(_RuntimeConfig) _then;

/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productName = freezed,Object? version = null,Object? target = freezed,Object? activeIp = freezed,Object? settings = null,Object? options = null,Object? config = null,}) {
  return _then(_RuntimeConfig(
productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String?,activeIp: freezed == activeIp ? _self.activeIp : activeIp // ignore: cast_nullable_to_non_nullable
as String?,settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,config: null == config ? _self._config : config // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
