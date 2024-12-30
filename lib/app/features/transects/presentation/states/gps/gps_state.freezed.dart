// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gps_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GpsState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLocationPermissionEnabled => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Create a copy of GpsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GpsStateCopyWith<GpsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GpsStateCopyWith<$Res> {
  factory $GpsStateCopyWith(GpsState value, $Res Function(GpsState) then) =
      _$GpsStateCopyWithImpl<$Res, GpsState>;
  @useResult
  $Res call(
      {bool isLoading, bool isLocationPermissionEnabled, String? message});
}

/// @nodoc
class _$GpsStateCopyWithImpl<$Res, $Val extends GpsState>
    implements $GpsStateCopyWith<$Res> {
  _$GpsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GpsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLocationPermissionEnabled = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationPermissionEnabled: null == isLocationPermissionEnabled
          ? _value.isLocationPermissionEnabled
          : isLocationPermissionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GpsStateImplCopyWith<$Res>
    implements $GpsStateCopyWith<$Res> {
  factory _$$GpsStateImplCopyWith(
          _$GpsStateImpl value, $Res Function(_$GpsStateImpl) then) =
      __$$GpsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading, bool isLocationPermissionEnabled, String? message});
}

/// @nodoc
class __$$GpsStateImplCopyWithImpl<$Res>
    extends _$GpsStateCopyWithImpl<$Res, _$GpsStateImpl>
    implements _$$GpsStateImplCopyWith<$Res> {
  __$$GpsStateImplCopyWithImpl(
      _$GpsStateImpl _value, $Res Function(_$GpsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of GpsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isLocationPermissionEnabled = null,
    Object? message = freezed,
  }) {
    return _then(_$GpsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLocationPermissionEnabled: null == isLocationPermissionEnabled
          ? _value.isLocationPermissionEnabled
          : isLocationPermissionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GpsStateImpl implements _GpsState {
  const _$GpsStateImpl(
      {required this.isLoading,
      required this.isLocationPermissionEnabled,
      required this.message});

  @override
  final bool isLoading;
  @override
  final bool isLocationPermissionEnabled;
  @override
  final String? message;

  @override
  String toString() {
    return 'GpsState(isLoading: $isLoading, isLocationPermissionEnabled: $isLocationPermissionEnabled, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GpsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLocationPermissionEnabled,
                    isLocationPermissionEnabled) ||
                other.isLocationPermissionEnabled ==
                    isLocationPermissionEnabled) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, isLocationPermissionEnabled, message);

  /// Create a copy of GpsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GpsStateImplCopyWith<_$GpsStateImpl> get copyWith =>
      __$$GpsStateImplCopyWithImpl<_$GpsStateImpl>(this, _$identity);
}

abstract class _GpsState implements GpsState {
  const factory _GpsState(
      {required final bool isLoading,
      required final bool isLocationPermissionEnabled,
      required final String? message}) = _$GpsStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isLocationPermissionEnabled;
  @override
  String? get message;

  /// Create a copy of GpsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GpsStateImplCopyWith<_$GpsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
