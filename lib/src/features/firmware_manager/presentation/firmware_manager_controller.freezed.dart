// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firmware_manager_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FirmwareManagerState {

 List<String> get availableVersions; List<String> get cachedVersions; bool get isLoading; Map<String, double> get downloadProgress; double get cacheSizeMb; FirmwareManagerError? get error;
/// Create a copy of FirmwareManagerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FirmwareManagerStateCopyWith<FirmwareManagerState> get copyWith => _$FirmwareManagerStateCopyWithImpl<FirmwareManagerState>(this as FirmwareManagerState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FirmwareManagerState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FirmwareManagerState&&const DeepCollectionEquality().equals(other.availableVersions, _this.availableVersions)&&const DeepCollectionEquality().equals(other.cachedVersions, _this.cachedVersions)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&const DeepCollectionEquality().equals(other.downloadProgress, _this.downloadProgress)&&(identical(other.cacheSizeMb, _this.cacheSizeMb) || other.cacheSizeMb == _this.cacheSizeMb)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as FirmwareManagerState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.availableVersions),const DeepCollectionEquality().hash(_this.cachedVersions),_this.isLoading,const DeepCollectionEquality().hash(_this.downloadProgress),_this.cacheSizeMb,_this.error);
}

@override
String toString() {
  final _this = this as FirmwareManagerState;
  return 'FirmwareManagerState(availableVersions: ${_this.availableVersions}, cachedVersions: ${_this.cachedVersions}, isLoading: ${_this.isLoading}, downloadProgress: ${_this.downloadProgress}, cacheSizeMb: ${_this.cacheSizeMb}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $FirmwareManagerStateCopyWith<$Res>  {
  factory $FirmwareManagerStateCopyWith(FirmwareManagerState value, $Res Function(FirmwareManagerState) _then) = _$FirmwareManagerStateCopyWithImpl;
@useResult
$Res call({
 List<String> availableVersions, List<String> cachedVersions, bool isLoading, Map<String, double> downloadProgress, double cacheSizeMb, FirmwareManagerError? error
});




}
/// @nodoc
class _$FirmwareManagerStateCopyWithImpl<$Res>
    implements $FirmwareManagerStateCopyWith<$Res> {
  _$FirmwareManagerStateCopyWithImpl(this._self, this._then);

  final FirmwareManagerState _self;
  final $Res Function(FirmwareManagerState) _then;

/// Create a copy of FirmwareManagerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availableVersions = null,Object? cachedVersions = null,Object? isLoading = null,Object? downloadProgress = null,Object? cacheSizeMb = null,Object? error = freezed,}) {
  return _then(FirmwareManagerState(
availableVersions: null == availableVersions ? _self.availableVersions : availableVersions // ignore: cast_nullable_to_non_nullable
as List<String>,cachedVersions: null == cachedVersions ? _self.cachedVersions : cachedVersions // ignore: cast_nullable_to_non_nullable
as List<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,downloadProgress: null == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as Map<String, double>,cacheSizeMb: null == cacheSizeMb ? _self.cacheSizeMb : cacheSizeMb // ignore: cast_nullable_to_non_nullable
as double,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as FirmwareManagerError?,
  ));
}

}


/// Adds pattern-matching-related methods to [FirmwareManagerState].
extension FirmwareManagerStatePatterns on FirmwareManagerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FirmwareManagerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FirmwareManagerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FirmwareManagerState value)  $default,){
final _that = this;
switch (_that) {
case _FirmwareManagerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FirmwareManagerState value)?  $default,){
final _that = this;
switch (_that) {
case _FirmwareManagerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> availableVersions,  List<String> cachedVersions,  bool isLoading,  Map<String, double> downloadProgress,  double cacheSizeMb,  FirmwareManagerError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FirmwareManagerState() when $default != null:
return $default(_that.availableVersions,_that.cachedVersions,_that.isLoading,_that.downloadProgress,_that.cacheSizeMb,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> availableVersions,  List<String> cachedVersions,  bool isLoading,  Map<String, double> downloadProgress,  double cacheSizeMb,  FirmwareManagerError? error)  $default,) {final _that = this;
switch (_that) {
case _FirmwareManagerState():
return $default(_that.availableVersions,_that.cachedVersions,_that.isLoading,_that.downloadProgress,_that.cacheSizeMb,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> availableVersions,  List<String> cachedVersions,  bool isLoading,  Map<String, double> downloadProgress,  double cacheSizeMb,  FirmwareManagerError? error)?  $default,) {final _that = this;
switch (_that) {
case _FirmwareManagerState() when $default != null:
return $default(_that.availableVersions,_that.cachedVersions,_that.isLoading,_that.downloadProgress,_that.cacheSizeMb,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _FirmwareManagerState implements FirmwareManagerState {
  const _FirmwareManagerState({ List<String> availableVersions = const [],  List<String> cachedVersions = const [], this.isLoading = false,  Map<String, double> downloadProgress = const {}, this.cacheSizeMb = 0.0, this.error}): _availableVersions = availableVersions,_cachedVersions = cachedVersions,_downloadProgress = downloadProgress;
  

 final  List<String> _availableVersions;
@override@JsonKey() List<String> get availableVersions {
  if (_availableVersions is EqualUnmodifiableListView) return _availableVersions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableVersions);
}

 final  List<String> _cachedVersions;
@override@JsonKey() List<String> get cachedVersions {
  if (_cachedVersions is EqualUnmodifiableListView) return _cachedVersions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cachedVersions);
}

@override@JsonKey() final  bool isLoading;
 final  Map<String, double> _downloadProgress;
@override@JsonKey() Map<String, double> get downloadProgress {
  if (_downloadProgress is EqualUnmodifiableMapView) return _downloadProgress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_downloadProgress);
}

@override@JsonKey() final  double cacheSizeMb;
@override final  FirmwareManagerError? error;

/// Create a copy of FirmwareManagerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirmwareManagerStateCopyWith<_FirmwareManagerState> get copyWith => __$FirmwareManagerStateCopyWithImpl<_FirmwareManagerState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirmwareManagerState&&const DeepCollectionEquality().equals(other.availableVersions, _availableVersions)&&const DeepCollectionEquality().equals(other.cachedVersions, _cachedVersions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.downloadProgress, _downloadProgress)&&(identical(other.cacheSizeMb, cacheSizeMb) || other.cacheSizeMb == cacheSizeMb)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_availableVersions),const DeepCollectionEquality().hash(_cachedVersions),isLoading,const DeepCollectionEquality().hash(_downloadProgress),cacheSizeMb,error);
}

@override
String toString() {
    return 'FirmwareManagerState(availableVersions: $availableVersions, cachedVersions: $cachedVersions, isLoading: $isLoading, downloadProgress: $downloadProgress, cacheSizeMb: $cacheSizeMb, error: $error)';
}


}

/// @nodoc
abstract mixin class _$FirmwareManagerStateCopyWith<$Res> implements $FirmwareManagerStateCopyWith<$Res> {
  factory _$FirmwareManagerStateCopyWith(_FirmwareManagerState value, $Res Function(_FirmwareManagerState) _then) = __$FirmwareManagerStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> availableVersions, List<String> cachedVersions, bool isLoading, Map<String, double> downloadProgress, double cacheSizeMb, FirmwareManagerError? error
});




}
/// @nodoc
class __$FirmwareManagerStateCopyWithImpl<$Res>
    implements _$FirmwareManagerStateCopyWith<$Res> {
  __$FirmwareManagerStateCopyWithImpl(this._self, this._then);

  final _FirmwareManagerState _self;
  final $Res Function(_FirmwareManagerState) _then;

/// Create a copy of FirmwareManagerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availableVersions = null,Object? cachedVersions = null,Object? isLoading = null,Object? downloadProgress = null,Object? cacheSizeMb = null,Object? error = freezed,}) {
  return _then(_FirmwareManagerState(
availableVersions: null == availableVersions ? _self._availableVersions : availableVersions // ignore: cast_nullable_to_non_nullable
as List<String>,cachedVersions: null == cachedVersions ? _self._cachedVersions : cachedVersions // ignore: cast_nullable_to_non_nullable
as List<String>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,downloadProgress: null == downloadProgress ? _self._downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as Map<String, double>,cacheSizeMb: null == cacheSizeMb ? _self.cacheSizeMb : cacheSizeMb // ignore: cast_nullable_to_non_nullable
as double,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as FirmwareManagerError?,
  ));
}


}

// dart format on
