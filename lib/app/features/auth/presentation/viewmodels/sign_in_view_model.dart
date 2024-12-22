import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/core/states/user_state.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_in_usecase.dart';

class SignInViewModel {
  final Ref _ref;
  final SignInUseCase _signInUseCase;

  SignInViewModel({required Ref ref, required SignInUseCase signInUseCase})
      : _ref = ref,
        _signInUseCase = signInUseCase;

  void signIn(String email, String password) async {
    _updateState((state) => state.copyWith(isLoading: true));

    final result = await _signInUseCase.execute(email, password);

    if (result.isSuccess) {
      _updateState(
          (state) => state.copyWith(isLoading: false, user: result.value));

      return;
    }

    _updateState((state) =>
        state.copyWith(isLoading: false, errorMessage: 'Cannot sign in'));
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
  /// authentication state.
  void _updateState(UserState Function(UserState) updateFn) {
    final currentState = _ref.read(currentUserStateProvider);
    _ref.read(currentUserStateProvider.notifier).state = updateFn(currentState);
  }
}
