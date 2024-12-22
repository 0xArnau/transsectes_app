import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';

part 'user_state.freezed.dart';

/// Represents the state of the user-related features.
@freezed
class UserState with _$UserState {
  const factory UserState({
    required bool isLoading, // Indicates whether the state is loading.
    required UserEntity? user, // Contains the user information (if available).
    required String? okMessage, // Contains a success message (if available).
    required String? errorMessage, // Contains an error message (if available).
  }) = _UserState;

  /// Returns the initial state of the user state.
  ///
  /// The initial state represents the state when no action has occurred yet.
  factory UserState.initial() => const UserState(
        isLoading: false,
        user: null,
        okMessage: null,
        errorMessage: null,
      );
}
