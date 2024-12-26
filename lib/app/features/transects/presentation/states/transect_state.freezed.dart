// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transect_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransectState {
  Stream<List<TransectEntity>> get transects =>
      throw _privateConstructorUsedError; // The list of transects
  bool get isLoading =>
      throw _privateConstructorUsedError; // Whether the data is still loading
  String? get okMessage =>
      throw _privateConstructorUsedError; // Success message, if any
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of TransectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransectStateCopyWith<TransectState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransectStateCopyWith<$Res> {
  factory $TransectStateCopyWith(
          TransectState value, $Res Function(TransectState) then) =
      _$TransectStateCopyWithImpl<$Res, TransectState>;
  @useResult
  $Res call(
      {Stream<List<TransectEntity>> transects,
      bool isLoading,
      String? okMessage,
      String? errorMessage});
}

/// @nodoc
class _$TransectStateCopyWithImpl<$Res, $Val extends TransectState>
    implements $TransectStateCopyWith<$Res> {
  _$TransectStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transects = null,
    Object? isLoading = null,
    Object? okMessage = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      transects: null == transects
          ? _value.transects
          : transects // ignore: cast_nullable_to_non_nullable
              as Stream<List<TransectEntity>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      okMessage: freezed == okMessage
          ? _value.okMessage
          : okMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransectStateImplCopyWith<$Res>
    implements $TransectStateCopyWith<$Res> {
  factory _$$TransectStateImplCopyWith(
          _$TransectStateImpl value, $Res Function(_$TransectStateImpl) then) =
      __$$TransectStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Stream<List<TransectEntity>> transects,
      bool isLoading,
      String? okMessage,
      String? errorMessage});
}

/// @nodoc
class __$$TransectStateImplCopyWithImpl<$Res>
    extends _$TransectStateCopyWithImpl<$Res, _$TransectStateImpl>
    implements _$$TransectStateImplCopyWith<$Res> {
  __$$TransectStateImplCopyWithImpl(
      _$TransectStateImpl _value, $Res Function(_$TransectStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransectState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transects = null,
    Object? isLoading = null,
    Object? okMessage = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$TransectStateImpl(
      transects: null == transects
          ? _value.transects
          : transects // ignore: cast_nullable_to_non_nullable
              as Stream<List<TransectEntity>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      okMessage: freezed == okMessage
          ? _value.okMessage
          : okMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TransectStateImpl implements _TransectState {
  const _$TransectStateImpl(
      {required this.transects,
      required this.isLoading,
      required this.okMessage,
      required this.errorMessage});

  @override
  final Stream<List<TransectEntity>> transects;
// The list of transects
  @override
  final bool isLoading;
// Whether the data is still loading
  @override
  final String? okMessage;
// Success message, if any
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'TransectState(transects: $transects, isLoading: $isLoading, okMessage: $okMessage, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransectStateImpl &&
            (identical(other.transects, transects) ||
                other.transects == transects) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.okMessage, okMessage) ||
                other.okMessage == okMessage) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, transects, isLoading, okMessage, errorMessage);

  /// Create a copy of TransectState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransectStateImplCopyWith<_$TransectStateImpl> get copyWith =>
      __$$TransectStateImplCopyWithImpl<_$TransectStateImpl>(this, _$identity);
}

abstract class _TransectState implements TransectState {
  const factory _TransectState(
      {required final Stream<List<TransectEntity>> transects,
      required final bool isLoading,
      required final String? okMessage,
      required final String? errorMessage}) = _$TransectStateImpl;

  @override
  Stream<List<TransectEntity>> get transects; // The list of transects
  @override
  bool get isLoading; // Whether the data is still loading
  @override
  String? get okMessage; // Success message, if any
  @override
  String? get errorMessage;

  /// Create a copy of TransectState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransectStateImplCopyWith<_$TransectStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
