import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/core/states/user_state.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/delete_user_account_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// ViewModel for the settings screen that manages the user's sign-out process
/// and manages updates to the user state.
class SettingsViewModel {
  final Ref _ref;
  final SignOutUseCase _signOutUseCase;
  final DeleteUserAccountUsecase _deleteUserAccountUsecase;

  /// Creates an instance of [SettingsViewModel].
  ///
  /// Takes a [ref] to the Riverpod reference and an instance of the [SignOutUseCase].
  /// The [ref] is used to interact with Riverpod providers, and the [signOutUseCase]
  /// handles the logic for signing out the user.
  SettingsViewModel(
      {required Ref ref,
      required SignOutUseCase signOutUseCase,
      required DeleteUserAccountUsecase deleteUserAccountUsecase})
      : _ref = ref,
        _signOutUseCase = signOutUseCase,
        _deleteUserAccountUsecase = deleteUserAccountUsecase;

  /// Signs the user out.
  ///
  /// This function initiates the sign-out process by calling the [SignOutUseCase].
  /// It updates the state to indicate the loading state while the sign-out request
  /// is being processed. Upon success, the user state is cleared. If the sign-out
  /// fails, an error message is displayed.
  void signOut() async {
    // Set loading state to true
    _updateState((state) => state.copyWith(
          isLoading: true,
        ));

    // Execute the sign-out use case
    final response = await _signOutUseCase.execute();

    if (response.isSuccess) {
      // Update the state after successful sign out
      _updateState((state) => state.copyWith(
            isLoading: false,
            user: null,
          ));
      return;
    }

    // Update the state with an error message if sign-out fails
    _updateState((state) => state.copyWith(
        isLoading: false, errorMessage: S.current.cannotSignOutTryAgain));
  }

  /// Deletes the user account and updates the state accordingly.
  ///
  /// This method invokes the use case to delete the user's account.
  /// It handles the loading state and propagates errors for further handling.
  ///
  /// Workflow:
  /// - Sets the loading state to true.
  /// - Attempts to delete the user account via the use case.
  /// - Updates the state to reflect the changes after the operation.
  ///
  /// Throws:
  /// - Any exception thrown during the account deletion process.
  Future<void> deleteUserAccount() async {
    try {
      _updateState(
        (state) => state.copyWith(
          isLoading: true,
        ),
      );

      await _deleteUserAccountUsecase.execute();

      _updateState(
        (state) => state.copyWith(
          isLoading: false,
          user: null,
        ),
      );
    } catch (e) {
      _updateState(
        (state) => state.copyWith(
          isLoading: false,
        ),
      );

      Logger().e(e);

      // Propagate the error for further handling by the UI.
      rethrow;
    }
  }

  /// Clears any error or success messages in the state.
  ///
  /// This function resets both the error and success messages, allowing the UI
  /// to reflect updated information without displaying outdated messages.
  void clearMessages() {
    _updateState(
        (state) => state.copyWith(okMessage: null, errorMessage: null));
  }

  /// Updates the state using a function that modifies the current state.
  ///
  /// This function is used to modify the current state by applying changes
  /// returned by [updateFn]. It helps keep the UI in sync with the current
  /// authentication state. It reads the current state using the Riverpod reference
  /// and updates the state notifier with the new state.
  void _updateState(UserState Function(UserState) updateFn) {
    final currentState = _ref.read(currentUserStateProvider);
    Logger().d(currentState);
    _ref.read(currentUserStateProvider.notifier).state = updateFn(currentState);
  }
}
