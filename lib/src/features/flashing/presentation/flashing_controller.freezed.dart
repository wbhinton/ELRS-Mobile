// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flashing_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FlashingState {

 String? get selectedVendor; TargetDefinition? get selectedTarget; String? get selectedVersion; FlashingStatus get status; double get progress; String? get errorMessage; String get bindPhrase; String get wifiSsid; String get wifiPassword; int get regulatoryDomain; String? get autosavingField;
/// Create a copy of FlashingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashingStateCopyWith<FlashingState> get copyWith => _$FlashingStateCopyWithImpl<FlashingState>(this as FlashingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashingState&&(identical(other.selectedVendor, selectedVendor) || other.selectedVendor == selectedVendor)&&(identical(other.selectedTarget, selectedTarget) || other.selectedTarget == selectedTarget)&&(identical(other.selectedVersion, selectedVersion) || other.selectedVersion == selectedVersion)&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.bindPhrase, bindPhrase) || other.bindPhrase == bindPhrase)&&(identical(other.wifiSsid, wifiSsid) || other.wifiSsid == wifiSsid)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&(identical(other.regulatoryDomain, regulatoryDomain) || other.regulatoryDomain == regulatoryDomain)&&(identical(other.autosavingField, autosavingField) || other.autosavingField == autosavingField));
}


@override
int get hashCode => Object.hash(runtimeType,selectedVendor,selectedTarget,selectedVersion,status,progress,errorMessage,bindPhrase,wifiSsid,wifiPassword,regulatoryDomain,autosavingField);

@override
String toString() {
  return 'FlashingState(selectedVendor: $selectedVendor, selectedTarget: $selectedTarget, selectedVersion: $selectedVersion, status: $status, progress: $progress, errorMessage: $errorMessage, bindPhrase: $bindPhrase, wifiSsid: $wifiSsid, wifiPassword: $wifiPassword, regulatoryDomain: $regulatoryDomain, autosavingField: $autosavingField)';
}


}

/// @nodoc
abstract mixin class $FlashingStateCopyWith<$Res>  {
  factory $FlashingStateCopyWith(FlashingState value, $Res Function(FlashingState) _then) = _$FlashingStateCopyWithImpl;
@useResult
$Res call({
 String? selectedVendor, TargetDefinition? selectedTarget, String? selectedVersion, FlashingStatus status, double progress, String? errorMessage, String bindPhrase, String wifiSsid, String wifiPassword, int regulatoryDomain, String? autosavingField
});


$TargetDefinitionCopyWith<$Res>? get selectedTarget;

}
/// @nodoc
class _$FlashingStateCopyWithImpl<$Res>
    implements $FlashingStateCopyWith<$Res> {
  _$FlashingStateCopyWithImpl(this._self, this._then);

  final FlashingState _self;
  final $Res Function(FlashingState) _then;

/// Create a copy of FlashingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedVendor = freezed,Object? selectedTarget = freezed,Object? selectedVersion = freezed,Object? status = null,Object? progress = null,Object? errorMessage = freezed,Object? bindPhrase = null,Object? wifiSsid = null,Object? wifiPassword = null,Object? regulatoryDomain = null,Object? autosavingField = freezed,}) {
  return _then(_self.copyWith(
selectedVendor: freezed == selectedVendor ? _self.selectedVendor : selectedVendor // ignore: cast_nullable_to_non_nullable
as String?,selectedTarget: freezed == selectedTarget ? _self.selectedTarget : selectedTarget // ignore: cast_nullable_to_non_nullable
as TargetDefinition?,selectedVersion: freezed == selectedVersion ? _self.selectedVersion : selectedVersion // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FlashingStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,bindPhrase: null == bindPhrase ? _self.bindPhrase : bindPhrase // ignore: cast_nullable_to_non_nullable
as String,wifiSsid: null == wifiSsid ? _self.wifiSsid : wifiSsid // ignore: cast_nullable_to_non_nullable
as String,wifiPassword: null == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String,regulatoryDomain: null == regulatoryDomain ? _self.regulatoryDomain : regulatoryDomain // ignore: cast_nullable_to_non_nullable
as int,autosavingField: freezed == autosavingField ? _self.autosavingField : autosavingField // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of FlashingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetDefinitionCopyWith<$Res>? get selectedTarget {
    if (_self.selectedTarget == null) {
    return null;
  }

  return $TargetDefinitionCopyWith<$Res>(_self.selectedTarget!, (value) {
    return _then(_self.copyWith(selectedTarget: value));
  });
}
}


/// Adds pattern-matching-related methods to [FlashingState].
extension FlashingStatePatterns on FlashingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlashingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlashingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlashingState value)  $default,){
final _that = this;
switch (_that) {
case _FlashingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlashingState value)?  $default,){
final _that = this;
switch (_that) {
case _FlashingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? selectedVendor,  TargetDefinition? selectedTarget,  String? selectedVersion,  FlashingStatus status,  double progress,  String? errorMessage,  String bindPhrase,  String wifiSsid,  String wifiPassword,  int regulatoryDomain,  String? autosavingField)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlashingState() when $default != null:
return $default(_that.selectedVendor,_that.selectedTarget,_that.selectedVersion,_that.status,_that.progress,_that.errorMessage,_that.bindPhrase,_that.wifiSsid,_that.wifiPassword,_that.regulatoryDomain,_that.autosavingField);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? selectedVendor,  TargetDefinition? selectedTarget,  String? selectedVersion,  FlashingStatus status,  double progress,  String? errorMessage,  String bindPhrase,  String wifiSsid,  String wifiPassword,  int regulatoryDomain,  String? autosavingField)  $default,) {final _that = this;
switch (_that) {
case _FlashingState():
return $default(_that.selectedVendor,_that.selectedTarget,_that.selectedVersion,_that.status,_that.progress,_that.errorMessage,_that.bindPhrase,_that.wifiSsid,_that.wifiPassword,_that.regulatoryDomain,_that.autosavingField);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? selectedVendor,  TargetDefinition? selectedTarget,  String? selectedVersion,  FlashingStatus status,  double progress,  String? errorMessage,  String bindPhrase,  String wifiSsid,  String wifiPassword,  int regulatoryDomain,  String? autosavingField)?  $default,) {final _that = this;
switch (_that) {
case _FlashingState() when $default != null:
return $default(_that.selectedVendor,_that.selectedTarget,_that.selectedVersion,_that.status,_that.progress,_that.errorMessage,_that.bindPhrase,_that.wifiSsid,_that.wifiPassword,_that.regulatoryDomain,_that.autosavingField);case _:
  return null;

}
}

}

/// @nodoc


class _FlashingState implements FlashingState {
  const _FlashingState({this.selectedVendor, this.selectedTarget, this.selectedVersion, this.status = FlashingStatus.idle, this.progress = 0.0, this.errorMessage, this.bindPhrase = '', this.wifiSsid = '', this.wifiPassword = '', this.regulatoryDomain = 0, this.autosavingField});
  

@override final  String? selectedVendor;
@override final  TargetDefinition? selectedTarget;
@override final  String? selectedVersion;
@override@JsonKey() final  FlashingStatus status;
@override@JsonKey() final  double progress;
@override final  String? errorMessage;
@override@JsonKey() final  String bindPhrase;
@override@JsonKey() final  String wifiSsid;
@override@JsonKey() final  String wifiPassword;
@override@JsonKey() final  int regulatoryDomain;
@override final  String? autosavingField;

/// Create a copy of FlashingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashingStateCopyWith<_FlashingState> get copyWith => __$FlashingStateCopyWithImpl<_FlashingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashingState&&(identical(other.selectedVendor, selectedVendor) || other.selectedVendor == selectedVendor)&&(identical(other.selectedTarget, selectedTarget) || other.selectedTarget == selectedTarget)&&(identical(other.selectedVersion, selectedVersion) || other.selectedVersion == selectedVersion)&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.bindPhrase, bindPhrase) || other.bindPhrase == bindPhrase)&&(identical(other.wifiSsid, wifiSsid) || other.wifiSsid == wifiSsid)&&(identical(other.wifiPassword, wifiPassword) || other.wifiPassword == wifiPassword)&&(identical(other.regulatoryDomain, regulatoryDomain) || other.regulatoryDomain == regulatoryDomain)&&(identical(other.autosavingField, autosavingField) || other.autosavingField == autosavingField));
}


@override
int get hashCode => Object.hash(runtimeType,selectedVendor,selectedTarget,selectedVersion,status,progress,errorMessage,bindPhrase,wifiSsid,wifiPassword,regulatoryDomain,autosavingField);

@override
String toString() {
  return 'FlashingState(selectedVendor: $selectedVendor, selectedTarget: $selectedTarget, selectedVersion: $selectedVersion, status: $status, progress: $progress, errorMessage: $errorMessage, bindPhrase: $bindPhrase, wifiSsid: $wifiSsid, wifiPassword: $wifiPassword, regulatoryDomain: $regulatoryDomain, autosavingField: $autosavingField)';
}


}

/// @nodoc
abstract mixin class _$FlashingStateCopyWith<$Res> implements $FlashingStateCopyWith<$Res> {
  factory _$FlashingStateCopyWith(_FlashingState value, $Res Function(_FlashingState) _then) = __$FlashingStateCopyWithImpl;
@override @useResult
$Res call({
 String? selectedVendor, TargetDefinition? selectedTarget, String? selectedVersion, FlashingStatus status, double progress, String? errorMessage, String bindPhrase, String wifiSsid, String wifiPassword, int regulatoryDomain, String? autosavingField
});


@override $TargetDefinitionCopyWith<$Res>? get selectedTarget;

}
/// @nodoc
class __$FlashingStateCopyWithImpl<$Res>
    implements _$FlashingStateCopyWith<$Res> {
  __$FlashingStateCopyWithImpl(this._self, this._then);

  final _FlashingState _self;
  final $Res Function(_FlashingState) _then;

/// Create a copy of FlashingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedVendor = freezed,Object? selectedTarget = freezed,Object? selectedVersion = freezed,Object? status = null,Object? progress = null,Object? errorMessage = freezed,Object? bindPhrase = null,Object? wifiSsid = null,Object? wifiPassword = null,Object? regulatoryDomain = null,Object? autosavingField = freezed,}) {
  return _then(_FlashingState(
selectedVendor: freezed == selectedVendor ? _self.selectedVendor : selectedVendor // ignore: cast_nullable_to_non_nullable
as String?,selectedTarget: freezed == selectedTarget ? _self.selectedTarget : selectedTarget // ignore: cast_nullable_to_non_nullable
as TargetDefinition?,selectedVersion: freezed == selectedVersion ? _self.selectedVersion : selectedVersion // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FlashingStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,bindPhrase: null == bindPhrase ? _self.bindPhrase : bindPhrase // ignore: cast_nullable_to_non_nullable
as String,wifiSsid: null == wifiSsid ? _self.wifiSsid : wifiSsid // ignore: cast_nullable_to_non_nullable
as String,wifiPassword: null == wifiPassword ? _self.wifiPassword : wifiPassword // ignore: cast_nullable_to_non_nullable
as String,regulatoryDomain: null == regulatoryDomain ? _self.regulatoryDomain : regulatoryDomain // ignore: cast_nullable_to_non_nullable
as int,autosavingField: freezed == autosavingField ? _self.autosavingField : autosavingField // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of FlashingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TargetDefinitionCopyWith<$Res>? get selectedTarget {
    if (_self.selectedTarget == null) {
    return null;
  }

  return $TargetDefinitionCopyWith<$Res>(_self.selectedTarget!, (value) {
    return _then(_self.copyWith(selectedTarget: value));
  });
}
}

// dart format on
