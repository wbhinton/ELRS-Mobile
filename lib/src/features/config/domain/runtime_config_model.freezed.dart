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

@JsonKey(name: 'product_name') String? get productName; String get version; String? get target; String? get activeIp; ElrsSettings get settings; ElrsOptions get options; ElrsConfig get config;
/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuntimeConfigCopyWith<RuntimeConfig> get copyWith => _$RuntimeConfigCopyWithImpl<RuntimeConfig>(this as RuntimeConfig, _$identity);

  /// Serializes this RuntimeConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuntimeConfig&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.version, version) || other.version == version)&&(identical(other.target, target) || other.target == target)&&(identical(other.activeIp, activeIp) || other.activeIp == activeIp)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.options, options) || other.options == options)&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,version,target,activeIp,settings,options,config);

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
@JsonKey(name: 'product_name') String? productName, String version, String? target, String? activeIp, ElrsSettings settings, ElrsOptions options, ElrsConfig config
});


$ElrsSettingsCopyWith<$Res> get settings;$ElrsOptionsCopyWith<$Res> get options;$ElrsConfigCopyWith<$Res> get config;

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
as ElrsSettings,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as ElrsOptions,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as ElrsConfig,
  ));
}
/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElrsSettingsCopyWith<$Res> get settings {
  
  return $ElrsSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElrsOptionsCopyWith<$Res> get options {
  
  return $ElrsOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElrsConfigCopyWith<$Res> get config {
  
  return $ElrsConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_name')  String? productName,  String version,  String? target,  String? activeIp,  ElrsSettings settings,  ElrsOptions options,  ElrsConfig config)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_name')  String? productName,  String version,  String? target,  String? activeIp,  ElrsSettings settings,  ElrsOptions options,  ElrsConfig config)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'product_name')  String? productName,  String version,  String? target,  String? activeIp,  ElrsSettings settings,  ElrsOptions options,  ElrsConfig config)?  $default,) {final _that = this;
switch (_that) {
case _RuntimeConfig() when $default != null:
return $default(_that.productName,_that.version,_that.target,_that.activeIp,_that.settings,_that.options,_that.config);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _RuntimeConfig implements RuntimeConfig {
  const _RuntimeConfig({@JsonKey(name: 'product_name') this.productName, this.version = 'unknown', this.target, this.activeIp, this.settings = const ElrsSettings(), this.options = const ElrsOptions(), this.config = const ElrsConfig()});
  factory _RuntimeConfig.fromJson(Map<String, dynamic> json) => _$RuntimeConfigFromJson(json);

@override@JsonKey(name: 'product_name') final  String? productName;
@override@JsonKey() final  String version;
@override final  String? target;
@override final  String? activeIp;
@override@JsonKey() final  ElrsSettings settings;
@override@JsonKey() final  ElrsOptions options;
@override@JsonKey() final  ElrsConfig config;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuntimeConfig&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.version, version) || other.version == version)&&(identical(other.target, target) || other.target == target)&&(identical(other.activeIp, activeIp) || other.activeIp == activeIp)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.options, options) || other.options == options)&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,version,target,activeIp,settings,options,config);

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
@JsonKey(name: 'product_name') String? productName, String version, String? target, String? activeIp, ElrsSettings settings, ElrsOptions options, ElrsConfig config
});


@override $ElrsSettingsCopyWith<$Res> get settings;@override $ElrsOptionsCopyWith<$Res> get options;@override $ElrsConfigCopyWith<$Res> get config;

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
as String?,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as ElrsSettings,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as ElrsOptions,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as ElrsConfig,
  ));
}

/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElrsSettingsCopyWith<$Res> get settings {
  
  return $ElrsSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElrsOptionsCopyWith<$Res> get options {
  
  return $ElrsOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}/// Create a copy of RuntimeConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElrsConfigCopyWith<$Res> get config {
  
  return $ElrsConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// @nodoc
mixin _$ElrsSettings {

@JsonKey(name: 'product_name') String? get productName; String? get version; String? get target;@JsonKey(name: 'module-type') String? get moduleType;@JsonKey(name: 'has_serial_pins') bool? get hasSerialPins;
/// Create a copy of ElrsSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElrsSettingsCopyWith<ElrsSettings> get copyWith => _$ElrsSettingsCopyWithImpl<ElrsSettings>(this as ElrsSettings, _$identity);

  /// Serializes this ElrsSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElrsSettings&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.version, version) || other.version == version)&&(identical(other.target, target) || other.target == target)&&(identical(other.moduleType, moduleType) || other.moduleType == moduleType)&&(identical(other.hasSerialPins, hasSerialPins) || other.hasSerialPins == hasSerialPins));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,version,target,moduleType,hasSerialPins);

@override
String toString() {
  return 'ElrsSettings(productName: $productName, version: $version, target: $target, moduleType: $moduleType, hasSerialPins: $hasSerialPins)';
}


}

/// @nodoc
abstract mixin class $ElrsSettingsCopyWith<$Res>  {
  factory $ElrsSettingsCopyWith(ElrsSettings value, $Res Function(ElrsSettings) _then) = _$ElrsSettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'product_name') String? productName, String? version, String? target,@JsonKey(name: 'module-type') String? moduleType,@JsonKey(name: 'has_serial_pins') bool? hasSerialPins
});




}
/// @nodoc
class _$ElrsSettingsCopyWithImpl<$Res>
    implements $ElrsSettingsCopyWith<$Res> {
  _$ElrsSettingsCopyWithImpl(this._self, this._then);

  final ElrsSettings _self;
  final $Res Function(ElrsSettings) _then;

/// Create a copy of ElrsSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productName = freezed,Object? version = freezed,Object? target = freezed,Object? moduleType = freezed,Object? hasSerialPins = freezed,}) {
  return _then(_self.copyWith(
productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String?,moduleType: freezed == moduleType ? _self.moduleType : moduleType // ignore: cast_nullable_to_non_nullable
as String?,hasSerialPins: freezed == hasSerialPins ? _self.hasSerialPins : hasSerialPins // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ElrsSettings].
extension ElrsSettingsPatterns on ElrsSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElrsSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElrsSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElrsSettings value)  $default,){
final _that = this;
switch (_that) {
case _ElrsSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElrsSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ElrsSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_name')  String? productName,  String? version,  String? target, @JsonKey(name: 'module-type')  String? moduleType, @JsonKey(name: 'has_serial_pins')  bool? hasSerialPins)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElrsSettings() when $default != null:
return $default(_that.productName,_that.version,_that.target,_that.moduleType,_that.hasSerialPins);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_name')  String? productName,  String? version,  String? target, @JsonKey(name: 'module-type')  String? moduleType, @JsonKey(name: 'has_serial_pins')  bool? hasSerialPins)  $default,) {final _that = this;
switch (_that) {
case _ElrsSettings():
return $default(_that.productName,_that.version,_that.target,_that.moduleType,_that.hasSerialPins);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'product_name')  String? productName,  String? version,  String? target, @JsonKey(name: 'module-type')  String? moduleType, @JsonKey(name: 'has_serial_pins')  bool? hasSerialPins)?  $default,) {final _that = this;
switch (_that) {
case _ElrsSettings() when $default != null:
return $default(_that.productName,_that.version,_that.target,_that.moduleType,_that.hasSerialPins);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ElrsSettings implements ElrsSettings {
  const _ElrsSettings({@JsonKey(name: 'product_name') this.productName, this.version, this.target, @JsonKey(name: 'module-type') this.moduleType, @JsonKey(name: 'has_serial_pins') this.hasSerialPins});
  factory _ElrsSettings.fromJson(Map<String, dynamic> json) => _$ElrsSettingsFromJson(json);

@override@JsonKey(name: 'product_name') final  String? productName;
@override final  String? version;
@override final  String? target;
@override@JsonKey(name: 'module-type') final  String? moduleType;
@override@JsonKey(name: 'has_serial_pins') final  bool? hasSerialPins;

/// Create a copy of ElrsSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElrsSettingsCopyWith<_ElrsSettings> get copyWith => __$ElrsSettingsCopyWithImpl<_ElrsSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElrsSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElrsSettings&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.version, version) || other.version == version)&&(identical(other.target, target) || other.target == target)&&(identical(other.moduleType, moduleType) || other.moduleType == moduleType)&&(identical(other.hasSerialPins, hasSerialPins) || other.hasSerialPins == hasSerialPins));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,version,target,moduleType,hasSerialPins);

@override
String toString() {
  return 'ElrsSettings(productName: $productName, version: $version, target: $target, moduleType: $moduleType, hasSerialPins: $hasSerialPins)';
}


}

/// @nodoc
abstract mixin class _$ElrsSettingsCopyWith<$Res> implements $ElrsSettingsCopyWith<$Res> {
  factory _$ElrsSettingsCopyWith(_ElrsSettings value, $Res Function(_ElrsSettings) _then) = __$ElrsSettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'product_name') String? productName, String? version, String? target,@JsonKey(name: 'module-type') String? moduleType,@JsonKey(name: 'has_serial_pins') bool? hasSerialPins
});




}
/// @nodoc
class __$ElrsSettingsCopyWithImpl<$Res>
    implements _$ElrsSettingsCopyWith<$Res> {
  __$ElrsSettingsCopyWithImpl(this._self, this._then);

  final _ElrsSettings _self;
  final $Res Function(_ElrsSettings) _then;

/// Create a copy of ElrsSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productName = freezed,Object? version = freezed,Object? target = freezed,Object? moduleType = freezed,Object? hasSerialPins = freezed,}) {
  return _then(_ElrsSettings(
productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String?,moduleType: freezed == moduleType ? _self.moduleType : moduleType // ignore: cast_nullable_to_non_nullable
as String?,hasSerialPins: freezed == hasSerialPins ? _self.hasSerialPins : hasSerialPins // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ElrsOptions {

 List<int>? get uid;@JsonKey(name: 'wifi-ssid') String? get wifiSsid;@JsonKey(name: 'wifi-password') String? get wifiPassword;@JsonKey(name: 'wifi-on-interval') int? get wifiOnInterval;@JsonKey(name: 'is-airport') bool? get isAirport;@JsonKey(name: 'airport-uart-baud') int? get airportUartBaud;@JsonKey(name: 'tlm-interval') int? get tlmInterval;@JsonKey(name: 'fan-runtime') int? get fanRuntime;@JsonKey(name: 'lock-on-first-connection') bool? get lockOnFirstConnection;@JsonKey(name: 'rcvr-uart-baud') int? get rcvrUartBaud;@JsonKey(name: 'dji-permanently-armed') bool? get djiPermanentlyArmed; int? get domain;
/// Create a copy of ElrsOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElrsOptionsCopyWith<ElrsOptions> get copyWith => _$ElrsOptionsCopyWithImpl<ElrsOptions>(this as ElrsOptions, _$identity);

  /// Serializes this ElrsOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElrsOptions&&const DeepCollectionEquality().equals(other.uid, uid)&&(identical(other.wifiSsid, wifiSsid) || other.wifiSsid == wifiSsid)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&(identical(other.wifiOnInterval, wifiOnInterval) || other.wifiOnInterval == wifiOnInterval)&&(identical(other.isAirport, isAirport) || other.isAirport == isAirport)&&(identical(other.airportUartBaud, airportUartBaud) || other.airportUartBaud == airportUartBaud)&&(identical(other.tlmInterval, tlmInterval) || other.tlmInterval == tlmInterval)&&(identical(other.fanRuntime, fanRuntime) || other.fanRuntime == fanRuntime)&&(identical(other.lockOnFirstConnection, lockOnFirstConnection) || other.lockOnFirstConnection == lockOnFirstConnection)&&(identical(other.rcvrUartBaud, rcvrUartBaud) || other.rcvrUartBaud == rcvrUartBaud)&&(identical(other.djiPermanentlyArmed, djiPermanentlyArmed) || other.djiPermanentlyArmed == djiPermanentlyArmed)&&(identical(other.domain, domain) || other.domain == domain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(uid),wifiSsid,wifiPassword,wifiOnInterval,isAirport,airportUartBaud,tlmInterval,fanRuntime,lockOnFirstConnection,rcvrUartBaud,djiPermanentlyArmed,domain);

@override
String toString() {
  return 'ElrsOptions(uid: $uid, wifiSsid: $wifiSsid, wifiPassword: $wifiPassword, wifiOnInterval: $wifiOnInterval, isAirport: $isAirport, airportUartBaud: $airportUartBaud, tlmInterval: $tlmInterval, fanRuntime: $fanRuntime, lockOnFirstConnection: $lockOnFirstConnection, rcvrUartBaud: $rcvrUartBaud, djiPermanentlyArmed: $djiPermanentlyArmed, domain: $domain)';
}


}

/// @nodoc
abstract mixin class $ElrsOptionsCopyWith<$Res>  {
  factory $ElrsOptionsCopyWith(ElrsOptions value, $Res Function(ElrsOptions) _then) = _$ElrsOptionsCopyWithImpl;
@useResult
$Res call({
 List<int>? uid,@JsonKey(name: 'wifi-ssid') String? wifiSsid,@JsonKey(name: 'wifi-password') String? wifiPassword,@JsonKey(name: 'wifi-on-interval') int? wifiOnInterval,@JsonKey(name: 'is-airport') bool? isAirport,@JsonKey(name: 'airport-uart-baud') int? airportUartBaud,@JsonKey(name: 'tlm-interval') int? tlmInterval,@JsonKey(name: 'fan-runtime') int? fanRuntime,@JsonKey(name: 'lock-on-first-connection') bool? lockOnFirstConnection,@JsonKey(name: 'rcvr-uart-baud') int? rcvrUartBaud,@JsonKey(name: 'dji-permanently-armed') bool? djiPermanentlyArmed, int? domain
});




}
/// @nodoc
class _$ElrsOptionsCopyWithImpl<$Res>
    implements $ElrsOptionsCopyWith<$Res> {
  _$ElrsOptionsCopyWithImpl(this._self, this._then);

  final ElrsOptions _self;
  final $Res Function(ElrsOptions) _then;

/// Create a copy of ElrsOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = freezed,Object? wifiSsid = freezed,Object? wifiPassword = freezed,Object? wifiOnInterval = freezed,Object? isAirport = freezed,Object? airportUartBaud = freezed,Object? tlmInterval = freezed,Object? fanRuntime = freezed,Object? lockOnFirstConnection = freezed,Object? rcvrUartBaud = freezed,Object? djiPermanentlyArmed = freezed,Object? domain = freezed,}) {
  return _then(_self.copyWith(
uid: freezed == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as List<int>?,wifiSsid: freezed == wifiSsid ? _self.wifiSsid : wifiSsid // ignore: cast_nullable_to_non_nullable
as String?,wifiPassword: freezed == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String?,wifiOnInterval: freezed == wifiOnInterval ? _self.wifiOnInterval : wifiOnInterval // ignore: cast_nullable_to_non_nullable
as int?,isAirport: freezed == isAirport ? _self.isAirport : isAirport // ignore: cast_nullable_to_non_nullable
as bool?,airportUartBaud: freezed == airportUartBaud ? _self.airportUartBaud : airportUartBaud // ignore: cast_nullable_to_non_nullable
as int?,tlmInterval: freezed == tlmInterval ? _self.tlmInterval : tlmInterval // ignore: cast_nullable_to_non_nullable
as int?,fanRuntime: freezed == fanRuntime ? _self.fanRuntime : fanRuntime // ignore: cast_nullable_to_non_nullable
as int?,lockOnFirstConnection: freezed == lockOnFirstConnection ? _self.lockOnFirstConnection : lockOnFirstConnection // ignore: cast_nullable_to_non_nullable
as bool?,rcvrUartBaud: freezed == rcvrUartBaud ? _self.rcvrUartBaud : rcvrUartBaud // ignore: cast_nullable_to_non_nullable
as int?,djiPermanentlyArmed: freezed == djiPermanentlyArmed ? _self.djiPermanentlyArmed : djiPermanentlyArmed // ignore: cast_nullable_to_non_nullable
as bool?,domain: freezed == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ElrsOptions].
extension ElrsOptionsPatterns on ElrsOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElrsOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElrsOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElrsOptions value)  $default,){
final _that = this;
switch (_that) {
case _ElrsOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElrsOptions value)?  $default,){
final _that = this;
switch (_that) {
case _ElrsOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int>? uid, @JsonKey(name: 'wifi-ssid')  String? wifiSsid, @JsonKey(name: 'wifi-password')  String? wifiPassword, @JsonKey(name: 'wifi-on-interval')  int? wifiOnInterval, @JsonKey(name: 'is-airport')  bool? isAirport, @JsonKey(name: 'airport-uart-baud')  int? airportUartBaud, @JsonKey(name: 'tlm-interval')  int? tlmInterval, @JsonKey(name: 'fan-runtime')  int? fanRuntime, @JsonKey(name: 'lock-on-first-connection')  bool? lockOnFirstConnection, @JsonKey(name: 'rcvr-uart-baud')  int? rcvrUartBaud, @JsonKey(name: 'dji-permanently-armed')  bool? djiPermanentlyArmed,  int? domain)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElrsOptions() when $default != null:
return $default(_that.uid,_that.wifiSsid,_that.wifiPassword,_that.wifiOnInterval,_that.isAirport,_that.airportUartBaud,_that.tlmInterval,_that.fanRuntime,_that.lockOnFirstConnection,_that.rcvrUartBaud,_that.djiPermanentlyArmed,_that.domain);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int>? uid, @JsonKey(name: 'wifi-ssid')  String? wifiSsid, @JsonKey(name: 'wifi-password')  String? wifiPassword, @JsonKey(name: 'wifi-on-interval')  int? wifiOnInterval, @JsonKey(name: 'is-airport')  bool? isAirport, @JsonKey(name: 'airport-uart-baud')  int? airportUartBaud, @JsonKey(name: 'tlm-interval')  int? tlmInterval, @JsonKey(name: 'fan-runtime')  int? fanRuntime, @JsonKey(name: 'lock-on-first-connection')  bool? lockOnFirstConnection, @JsonKey(name: 'rcvr-uart-baud')  int? rcvrUartBaud, @JsonKey(name: 'dji-permanently-armed')  bool? djiPermanentlyArmed,  int? domain)  $default,) {final _that = this;
switch (_that) {
case _ElrsOptions():
return $default(_that.uid,_that.wifiSsid,_that.wifiPassword,_that.wifiOnInterval,_that.isAirport,_that.airportUartBaud,_that.tlmInterval,_that.fanRuntime,_that.lockOnFirstConnection,_that.rcvrUartBaud,_that.djiPermanentlyArmed,_that.domain);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int>? uid, @JsonKey(name: 'wifi-ssid')  String? wifiSsid, @JsonKey(name: 'wifi-password')  String? wifiPassword, @JsonKey(name: 'wifi-on-interval')  int? wifiOnInterval, @JsonKey(name: 'is-airport')  bool? isAirport, @JsonKey(name: 'airport-uart-baud')  int? airportUartBaud, @JsonKey(name: 'tlm-interval')  int? tlmInterval, @JsonKey(name: 'fan-runtime')  int? fanRuntime, @JsonKey(name: 'lock-on-first-connection')  bool? lockOnFirstConnection, @JsonKey(name: 'rcvr-uart-baud')  int? rcvrUartBaud, @JsonKey(name: 'dji-permanently-armed')  bool? djiPermanentlyArmed,  int? domain)?  $default,) {final _that = this;
switch (_that) {
case _ElrsOptions() when $default != null:
return $default(_that.uid,_that.wifiSsid,_that.wifiPassword,_that.wifiOnInterval,_that.isAirport,_that.airportUartBaud,_that.tlmInterval,_that.fanRuntime,_that.lockOnFirstConnection,_that.rcvrUartBaud,_that.djiPermanentlyArmed,_that.domain);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ElrsOptions implements ElrsOptions {
  const _ElrsOptions({final  List<int>? uid, @JsonKey(name: 'wifi-ssid') this.wifiSsid, @JsonKey(name: 'wifi-password') this.wifiPassword, @JsonKey(name: 'wifi-on-interval') this.wifiOnInterval, @JsonKey(name: 'is-airport') this.isAirport, @JsonKey(name: 'airport-uart-baud') this.airportUartBaud, @JsonKey(name: 'tlm-interval') this.tlmInterval, @JsonKey(name: 'fan-runtime') this.fanRuntime, @JsonKey(name: 'lock-on-first-connection') this.lockOnFirstConnection, @JsonKey(name: 'rcvr-uart-baud') this.rcvrUartBaud, @JsonKey(name: 'dji-permanently-armed') this.djiPermanentlyArmed, this.domain}): _uid = uid;
  factory _ElrsOptions.fromJson(Map<String, dynamic> json) => _$ElrsOptionsFromJson(json);

 final  List<int>? _uid;
@override List<int>? get uid {
  final value = _uid;
  if (value == null) return null;
  if (_uid is EqualUnmodifiableListView) return _uid;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'wifi-ssid') final  String? wifiSsid;
@override@JsonKey(name: 'wifi-password') final  String? wifiPassword;
@override@JsonKey(name: 'wifi-on-interval') final  int? wifiOnInterval;
@override@JsonKey(name: 'is-airport') final  bool? isAirport;
@override@JsonKey(name: 'airport-uart-baud') final  int? airportUartBaud;
@override@JsonKey(name: 'tlm-interval') final  int? tlmInterval;
@override@JsonKey(name: 'fan-runtime') final  int? fanRuntime;
@override@JsonKey(name: 'lock-on-first-connection') final  bool? lockOnFirstConnection;
@override@JsonKey(name: 'rcvr-uart-baud') final  int? rcvrUartBaud;
@override@JsonKey(name: 'dji-permanently-armed') final  bool? djiPermanentlyArmed;
@override final  int? domain;

/// Create a copy of ElrsOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElrsOptionsCopyWith<_ElrsOptions> get copyWith => __$ElrsOptionsCopyWithImpl<_ElrsOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElrsOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElrsOptions&&const DeepCollectionEquality().equals(other._uid, _uid)&&(identical(other.wifiSsid, wifiSsid) || other.wifiSsid == wifiSsid)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&(identical(other.wifiOnInterval, wifiOnInterval) || other.wifiOnInterval == wifiOnInterval)&&(identical(other.isAirport, isAirport) || other.isAirport == isAirport)&&(identical(other.airportUartBaud, airportUartBaud) || other.airportUartBaud == airportUartBaud)&&(identical(other.tlmInterval, tlmInterval) || other.tlmInterval == tlmInterval)&&(identical(other.fanRuntime, fanRuntime) || other.fanRuntime == fanRuntime)&&(identical(other.lockOnFirstConnection, lockOnFirstConnection) || other.lockOnFirstConnection == lockOnFirstConnection)&&(identical(other.rcvrUartBaud, rcvrUartBaud) || other.rcvrUartBaud == rcvrUartBaud)&&(identical(other.djiPermanentlyArmed, djiPermanentlyArmed) || other.djiPermanentlyArmed == djiPermanentlyArmed)&&(identical(other.domain, domain) || other.domain == domain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_uid),wifiSsid,wifiPassword,wifiOnInterval,isAirport,airportUartBaud,tlmInterval,fanRuntime,lockOnFirstConnection,rcvrUartBaud,djiPermanentlyArmed,domain);

@override
String toString() {
  return 'ElrsOptions(uid: $uid, wifiSsid: $wifiSsid, wifiPassword: $wifiPassword, wifiOnInterval: $wifiOnInterval, isAirport: $isAirport, airportUartBaud: $airportUartBaud, tlmInterval: $tlmInterval, fanRuntime: $fanRuntime, lockOnFirstConnection: $lockOnFirstConnection, rcvrUartBaud: $rcvrUartBaud, djiPermanentlyArmed: $djiPermanentlyArmed, domain: $domain)';
}


}

/// @nodoc
abstract mixin class _$ElrsOptionsCopyWith<$Res> implements $ElrsOptionsCopyWith<$Res> {
  factory _$ElrsOptionsCopyWith(_ElrsOptions value, $Res Function(_ElrsOptions) _then) = __$ElrsOptionsCopyWithImpl;
@override @useResult
$Res call({
 List<int>? uid,@JsonKey(name: 'wifi-ssid') String? wifiSsid,@JsonKey(name: 'wifi-password') String? wifiPassword,@JsonKey(name: 'wifi-on-interval') int? wifiOnInterval,@JsonKey(name: 'is-airport') bool? isAirport,@JsonKey(name: 'airport-uart-baud') int? airportUartBaud,@JsonKey(name: 'tlm-interval') int? tlmInterval,@JsonKey(name: 'fan-runtime') int? fanRuntime,@JsonKey(name: 'lock-on-first-connection') bool? lockOnFirstConnection,@JsonKey(name: 'rcvr-uart-baud') int? rcvrUartBaud,@JsonKey(name: 'dji-permanently-armed') bool? djiPermanentlyArmed, int? domain
});




}
/// @nodoc
class __$ElrsOptionsCopyWithImpl<$Res>
    implements _$ElrsOptionsCopyWith<$Res> {
  __$ElrsOptionsCopyWithImpl(this._self, this._then);

  final _ElrsOptions _self;
  final $Res Function(_ElrsOptions) _then;

/// Create a copy of ElrsOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = freezed,Object? wifiSsid = freezed,Object? wifiPassword = freezed,Object? wifiOnInterval = freezed,Object? isAirport = freezed,Object? airportUartBaud = freezed,Object? tlmInterval = freezed,Object? fanRuntime = freezed,Object? lockOnFirstConnection = freezed,Object? rcvrUartBaud = freezed,Object? djiPermanentlyArmed = freezed,Object? domain = freezed,}) {
  return _then(_ElrsOptions(
uid: freezed == uid ? _self._uid : uid // ignore: cast_nullable_to_non_nullable
as List<int>?,wifiSsid: freezed == wifiSsid ? _self.wifiSsid : wifiSsid // ignore: cast_nullable_to_non_nullable
as String?,wifiPassword: freezed == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String?,wifiOnInterval: freezed == wifiOnInterval ? _self.wifiOnInterval : wifiOnInterval // ignore: cast_nullable_to_non_nullable
as int?,isAirport: freezed == isAirport ? _self.isAirport : isAirport // ignore: cast_nullable_to_non_nullable
as bool?,airportUartBaud: freezed == airportUartBaud ? _self.airportUartBaud : airportUartBaud // ignore: cast_nullable_to_non_nullable
as int?,tlmInterval: freezed == tlmInterval ? _self.tlmInterval : tlmInterval // ignore: cast_nullable_to_non_nullable
as int?,fanRuntime: freezed == fanRuntime ? _self.fanRuntime : fanRuntime // ignore: cast_nullable_to_non_nullable
as int?,lockOnFirstConnection: freezed == lockOnFirstConnection ? _self.lockOnFirstConnection : lockOnFirstConnection // ignore: cast_nullable_to_non_nullable
as bool?,rcvrUartBaud: freezed == rcvrUartBaud ? _self.rcvrUartBaud : rcvrUartBaud // ignore: cast_nullable_to_non_nullable
as int?,djiPermanentlyArmed: freezed == djiPermanentlyArmed ? _self.djiPermanentlyArmed : djiPermanentlyArmed // ignore: cast_nullable_to_non_nullable
as bool?,domain: freezed == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ElrsConfig {

@JsonKey(name: 'modelid') int? get modelId;@JsonKey(name: 'force-tlm') bool? get forceTlm; int? get vbind;@JsonKey(name: 'serial-protocol') int? get serialProtocol;@JsonKey(name: 'serial1-protocol') int? get serial1Protocol;@JsonKey(name: 'sbus-failsafe') int? get sbusFailsafe; List<dynamic> get pwm; Map<String, dynamic>? get hardware;
/// Create a copy of ElrsConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElrsConfigCopyWith<ElrsConfig> get copyWith => _$ElrsConfigCopyWithImpl<ElrsConfig>(this as ElrsConfig, _$identity);

  /// Serializes this ElrsConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElrsConfig&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.forceTlm, forceTlm) || other.forceTlm == forceTlm)&&(identical(other.vbind, vbind) || other.vbind == vbind)&&(identical(other.serialProtocol, serialProtocol) || other.serialProtocol == serialProtocol)&&(identical(other.serial1Protocol, serial1Protocol) || other.serial1Protocol == serial1Protocol)&&(identical(other.sbusFailsafe, sbusFailsafe) || other.sbusFailsafe == sbusFailsafe)&&const DeepCollectionEquality().equals(other.pwm, pwm)&&const DeepCollectionEquality().equals(other.hardware, hardware));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelId,forceTlm,vbind,serialProtocol,serial1Protocol,sbusFailsafe,const DeepCollectionEquality().hash(pwm),const DeepCollectionEquality().hash(hardware));

@override
String toString() {
  return 'ElrsConfig(modelId: $modelId, forceTlm: $forceTlm, vbind: $vbind, serialProtocol: $serialProtocol, serial1Protocol: $serial1Protocol, sbusFailsafe: $sbusFailsafe, pwm: $pwm, hardware: $hardware)';
}


}

/// @nodoc
abstract mixin class $ElrsConfigCopyWith<$Res>  {
  factory $ElrsConfigCopyWith(ElrsConfig value, $Res Function(ElrsConfig) _then) = _$ElrsConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'modelid') int? modelId,@JsonKey(name: 'force-tlm') bool? forceTlm, int? vbind,@JsonKey(name: 'serial-protocol') int? serialProtocol,@JsonKey(name: 'serial1-protocol') int? serial1Protocol,@JsonKey(name: 'sbus-failsafe') int? sbusFailsafe, List<dynamic> pwm, Map<String, dynamic>? hardware
});




}
/// @nodoc
class _$ElrsConfigCopyWithImpl<$Res>
    implements $ElrsConfigCopyWith<$Res> {
  _$ElrsConfigCopyWithImpl(this._self, this._then);

  final ElrsConfig _self;
  final $Res Function(ElrsConfig) _then;

/// Create a copy of ElrsConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modelId = freezed,Object? forceTlm = freezed,Object? vbind = freezed,Object? serialProtocol = freezed,Object? serial1Protocol = freezed,Object? sbusFailsafe = freezed,Object? pwm = null,Object? hardware = freezed,}) {
  return _then(_self.copyWith(
modelId: freezed == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as int?,forceTlm: freezed == forceTlm ? _self.forceTlm : forceTlm // ignore: cast_nullable_to_non_nullable
as bool?,vbind: freezed == vbind ? _self.vbind : vbind // ignore: cast_nullable_to_non_nullable
as int?,serialProtocol: freezed == serialProtocol ? _self.serialProtocol : serialProtocol // ignore: cast_nullable_to_non_nullable
as int?,serial1Protocol: freezed == serial1Protocol ? _self.serial1Protocol : serial1Protocol // ignore: cast_nullable_to_non_nullable
as int?,sbusFailsafe: freezed == sbusFailsafe ? _self.sbusFailsafe : sbusFailsafe // ignore: cast_nullable_to_non_nullable
as int?,pwm: null == pwm ? _self.pwm : pwm // ignore: cast_nullable_to_non_nullable
as List<dynamic>,hardware: freezed == hardware ? _self.hardware : hardware // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ElrsConfig].
extension ElrsConfigPatterns on ElrsConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElrsConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElrsConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElrsConfig value)  $default,){
final _that = this;
switch (_that) {
case _ElrsConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElrsConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ElrsConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'modelid')  int? modelId, @JsonKey(name: 'force-tlm')  bool? forceTlm,  int? vbind, @JsonKey(name: 'serial-protocol')  int? serialProtocol, @JsonKey(name: 'serial1-protocol')  int? serial1Protocol, @JsonKey(name: 'sbus-failsafe')  int? sbusFailsafe,  List<dynamic> pwm,  Map<String, dynamic>? hardware)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElrsConfig() when $default != null:
return $default(_that.modelId,_that.forceTlm,_that.vbind,_that.serialProtocol,_that.serial1Protocol,_that.sbusFailsafe,_that.pwm,_that.hardware);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'modelid')  int? modelId, @JsonKey(name: 'force-tlm')  bool? forceTlm,  int? vbind, @JsonKey(name: 'serial-protocol')  int? serialProtocol, @JsonKey(name: 'serial1-protocol')  int? serial1Protocol, @JsonKey(name: 'sbus-failsafe')  int? sbusFailsafe,  List<dynamic> pwm,  Map<String, dynamic>? hardware)  $default,) {final _that = this;
switch (_that) {
case _ElrsConfig():
return $default(_that.modelId,_that.forceTlm,_that.vbind,_that.serialProtocol,_that.serial1Protocol,_that.sbusFailsafe,_that.pwm,_that.hardware);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'modelid')  int? modelId, @JsonKey(name: 'force-tlm')  bool? forceTlm,  int? vbind, @JsonKey(name: 'serial-protocol')  int? serialProtocol, @JsonKey(name: 'serial1-protocol')  int? serial1Protocol, @JsonKey(name: 'sbus-failsafe')  int? sbusFailsafe,  List<dynamic> pwm,  Map<String, dynamic>? hardware)?  $default,) {final _that = this;
switch (_that) {
case _ElrsConfig() when $default != null:
return $default(_that.modelId,_that.forceTlm,_that.vbind,_that.serialProtocol,_that.serial1Protocol,_that.sbusFailsafe,_that.pwm,_that.hardware);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ElrsConfig implements ElrsConfig {
  const _ElrsConfig({@JsonKey(name: 'modelid') this.modelId, @JsonKey(name: 'force-tlm') this.forceTlm, this.vbind, @JsonKey(name: 'serial-protocol') this.serialProtocol, @JsonKey(name: 'serial1-protocol') this.serial1Protocol, @JsonKey(name: 'sbus-failsafe') this.sbusFailsafe, final  List<dynamic> pwm = const [], final  Map<String, dynamic>? hardware}): _pwm = pwm,_hardware = hardware;
  factory _ElrsConfig.fromJson(Map<String, dynamic> json) => _$ElrsConfigFromJson(json);

@override@JsonKey(name: 'modelid') final  int? modelId;
@override@JsonKey(name: 'force-tlm') final  bool? forceTlm;
@override final  int? vbind;
@override@JsonKey(name: 'serial-protocol') final  int? serialProtocol;
@override@JsonKey(name: 'serial1-protocol') final  int? serial1Protocol;
@override@JsonKey(name: 'sbus-failsafe') final  int? sbusFailsafe;
 final  List<dynamic> _pwm;
@override@JsonKey() List<dynamic> get pwm {
  if (_pwm is EqualUnmodifiableListView) return _pwm;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pwm);
}

 final  Map<String, dynamic>? _hardware;
@override Map<String, dynamic>? get hardware {
  final value = _hardware;
  if (value == null) return null;
  if (_hardware is EqualUnmodifiableMapView) return _hardware;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ElrsConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElrsConfigCopyWith<_ElrsConfig> get copyWith => __$ElrsConfigCopyWithImpl<_ElrsConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElrsConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElrsConfig&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.forceTlm, forceTlm) || other.forceTlm == forceTlm)&&(identical(other.vbind, vbind) || other.vbind == vbind)&&(identical(other.serialProtocol, serialProtocol) || other.serialProtocol == serialProtocol)&&(identical(other.serial1Protocol, serial1Protocol) || other.serial1Protocol == serial1Protocol)&&(identical(other.sbusFailsafe, sbusFailsafe) || other.sbusFailsafe == sbusFailsafe)&&const DeepCollectionEquality().equals(other._pwm, _pwm)&&const DeepCollectionEquality().equals(other._hardware, _hardware));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,modelId,forceTlm,vbind,serialProtocol,serial1Protocol,sbusFailsafe,const DeepCollectionEquality().hash(_pwm),const DeepCollectionEquality().hash(_hardware));

@override
String toString() {
  return 'ElrsConfig(modelId: $modelId, forceTlm: $forceTlm, vbind: $vbind, serialProtocol: $serialProtocol, serial1Protocol: $serial1Protocol, sbusFailsafe: $sbusFailsafe, pwm: $pwm, hardware: $hardware)';
}


}

/// @nodoc
abstract mixin class _$ElrsConfigCopyWith<$Res> implements $ElrsConfigCopyWith<$Res> {
  factory _$ElrsConfigCopyWith(_ElrsConfig value, $Res Function(_ElrsConfig) _then) = __$ElrsConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'modelid') int? modelId,@JsonKey(name: 'force-tlm') bool? forceTlm, int? vbind,@JsonKey(name: 'serial-protocol') int? serialProtocol,@JsonKey(name: 'serial1-protocol') int? serial1Protocol,@JsonKey(name: 'sbus-failsafe') int? sbusFailsafe, List<dynamic> pwm, Map<String, dynamic>? hardware
});




}
/// @nodoc
class __$ElrsConfigCopyWithImpl<$Res>
    implements _$ElrsConfigCopyWith<$Res> {
  __$ElrsConfigCopyWithImpl(this._self, this._then);

  final _ElrsConfig _self;
  final $Res Function(_ElrsConfig) _then;

/// Create a copy of ElrsConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modelId = freezed,Object? forceTlm = freezed,Object? vbind = freezed,Object? serialProtocol = freezed,Object? serial1Protocol = freezed,Object? sbusFailsafe = freezed,Object? pwm = null,Object? hardware = freezed,}) {
  return _then(_ElrsConfig(
modelId: freezed == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as int?,forceTlm: freezed == forceTlm ? _self.forceTlm : forceTlm // ignore: cast_nullable_to_non_nullable
as bool?,vbind: freezed == vbind ? _self.vbind : vbind // ignore: cast_nullable_to_non_nullable
as int?,serialProtocol: freezed == serialProtocol ? _self.serialProtocol : serialProtocol // ignore: cast_nullable_to_non_nullable
as int?,serial1Protocol: freezed == serial1Protocol ? _self.serial1Protocol : serial1Protocol // ignore: cast_nullable_to_non_nullable
as int?,sbusFailsafe: freezed == sbusFailsafe ? _self.sbusFailsafe : sbusFailsafe // ignore: cast_nullable_to_non_nullable
as int?,pwm: null == pwm ? _self._pwm : pwm // ignore: cast_nullable_to_non_nullable
as List<dynamic>,hardware: freezed == hardware ? _self._hardware : hardware // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
