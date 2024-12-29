// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transect_coordinates_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransectCoordinatesState {
  List<GeoPointEntity> get coordinates => throw _privateConstructorUsedError;
  bool get isStarted => throw _privateConstructorUsedError;
  bool get isStopped => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get okMessage => throw _privateConstructorUsedError;

  /// Create a copy of TransectCoordinatesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransectCoordinatesStateCopyWith<TransectCoordinatesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransectCoordinatesStateCopyWith<$Res> {
  factory $TransectCoordinatesStateCopyWith(TransectCoordinatesState value,
          $Res Function(TransectCoordinatesState) then) =
      _$TransectCoordinatesStateCopyWithImpl<$Res, TransectCoordinatesState>;
  @useResult
  $Res call(
      {List<GeoPointEntity> coordinates,
      bool isStarted,
      bool isStopped,
      bool isLoading,
      String? errorMessage,
      String? okMessage});
}

/// @nodoc
class _$TransectCoordinatesStateCopyWithImpl<$Res,
        $Val extends TransectCoordinatesState>
    implements $TransectCoordinatesStateCopyWith<$Res> {
  _$TransectCoordinatesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransectCoordinatesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coordinates = null,
    Object? isStarted = null,
    Object? isStopped = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? okMessage = freezed,
  }) {
    return _then(_value.copyWith(
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<GeoPointEntity>,
      isStarted: null == isStarted
          ? _value.isStarted
          : isStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      isStopped: null == isStopped
          ? _value.isStopped
          : isStopped // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      okMessage: freezed == okMessage
          ? _value.okMessage
          : okMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransectCoordinatesStateImplCopyWith<$Res>
    implements $TransectCoordinatesStateCopyWith<$Res> {
  factory _$$TransectCoordinatesStateImplCopyWith(
          _$TransectCoordinatesStateImpl value,
          $Res Function(_$TransectCoordinatesStateImpl) then) =
      __$$TransectCoordinatesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<GeoPointEntity> coordinates,
      bool isStarted,
      bool isStopped,
      bool isLoading,
      String? errorMessage,
      String? okMessage});
}

/// @nodoc
class __$$TransectCoordinatesStateImplCopyWithImpl<$Res>
    extends _$TransectCoordinatesStateCopyWithImpl<$Res,
        _$TransectCoordinatesStateImpl>
    implements _$$TransectCoordinatesStateImplCopyWith<$Res> {
  __$$TransectCoordinatesStateImplCopyWithImpl(
      _$TransectCoordinatesStateImpl _value,
      $Res Function(_$TransectCoordinatesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransectCoordinatesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coordinates = null,
    Object? isStarted = null,
    Object? isStopped = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? okMessage = freezed,
  }) {
    return _then(_$TransectCoordinatesStateImpl(
      coordinates: null == coordinates
          ? _value._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<GeoPointEntity>,
      isStarted: null == isStarted
          ? _value.isStarted
          : isStarted // ignore: cast_nullable_to_non_nullable
              as bool,
      isStopped: null == isStopped
          ? _value.isStopped
          : isStopped // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      okMessage: freezed == okMessage
          ? _value.okMessage
          : okMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TransectCoordinatesStateImpl implements _TransectCoordinatesState {
  const _$TransectCoordinatesStateImpl(
      {required final List<GeoPointEntity> coordinates,
      required this.isStarted,
      required this.isStopped,
      required this.isLoading,
      required this.errorMessage,
      required this.okMessage})
      : _coordinates = coordinates;

  final List<GeoPointEntity> _coordinates;
  @override
  List<GeoPointEntity> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @override
  final bool isStarted;
  @override
  final bool isStopped;
  @override
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  final String? okMessage;

  @override
  String toString() {
    return 'TransectCoordinatesState(coordinates: $coordinates, isStarted: $isStarted, isStopped: $isStopped, isLoading: $isLoading, errorMessage: $errorMessage, okMessage: $okMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransectCoordinatesStateImpl &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates) &&
            (identical(other.isStarted, isStarted) ||
                other.isStarted == isStarted) &&
            (identical(other.isStopped, isStopped) ||
                other.isStopped == isStopped) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.okMessage, okMessage) ||
                other.okMessage == okMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_coordinates),
      isStarted,
      isStopped,
      isLoading,
      errorMessage,
      okMessage);

  /// Create a copy of TransectCoordinatesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransectCoordinatesStateImplCopyWith<_$TransectCoordinatesStateImpl>
      get copyWith => __$$TransectCoordinatesStateImplCopyWithImpl<
          _$TransectCoordinatesStateImpl>(this, _$identity);
}

abstract class _TransectCoordinatesState implements TransectCoordinatesState {
  const factory _TransectCoordinatesState(
      {required final List<GeoPointEntity> coordinates,
      required final bool isStarted,
      required final bool isStopped,
      required final bool isLoading,
      required final String? errorMessage,
      required final String? okMessage}) = _$TransectCoordinatesStateImpl;

  @override
  List<GeoPointEntity> get coordinates;
  @override
  bool get isStarted;
  @override
  bool get isStopped;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  String? get okMessage;

  /// Create a copy of TransectCoordinatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransectCoordinatesStateImplCopyWith<_$TransectCoordinatesStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
