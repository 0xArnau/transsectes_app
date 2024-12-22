import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/is_user_authenticated_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/core/states/user_state.dart';

/// ViewModel responsible for handling user authentication state.
///
/// This ViewModel checks if the user is authenticated and retrieves the
/// current user information if authenticated. It also handles state updates
/// related to authentication and error messages.
class AuthViewModel {
  final Ref _ref;
  final IsUserAuthenticatedUseCase _isUserAuthenticatedUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  /// Constructor for the ViewModel.
  ///
  /// Requires [ref] to access Riverpod providers,
  /// [isUserAuthenticatedUseCase] to check if the user is authenticated,
  /// [getCurrentUserUseCase] to retrieve current user details.
  AuthViewModel({
    required Ref ref,
    required IsUserAuthenticatedUseCase isUserAuthenticatedUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  })  : _ref = ref,
        _isUserAuthenticatedUseCase = isUserAuthenticatedUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase;

  /// Initializes the ViewModel by checking if the user is authenticated
  /// and retrieving the current user information if authenticated.
  ///
  /// This method updates the state to show loading initially. Then, it checks
  /// if the user is authenticated. If authenticated, it fetches the user details
  /// and updates the state accordingly. Otherwise, it stops loading.
  void initialize() {
    _updateState((state) => state.copyWith(
          isLoading: true,
        ));

    // Check if the user is authenticated
    final isAuthenticated = _isUserAuthenticated();
    if (!isAuthenticated) {
      _updateState((state) => state.copyWith(
            isLoading: false,
          ));
      return;
    }

    // If authenticated, fetch the current user
    final user = _getCurrentUser();
    _updateState((state) => state.copyWith(
          isLoading: false,
          user: user,
        ));
  }

  /// Retrieves the current user information from the use case.
  ///
  /// This method calls [GetCurrentUserUseCase] to fetch the current user
  /// details. If successful, it returns the user entity. If there is an error,
  /// it updates the state with an error message.
  UserEntity? _getCurrentUser() {
    final result = _getCurrentUserUseCase.execute();

    if (result.isSuccess) {
      return result.value;
    }

    if (result.isFailure) {
      _updateState((state) => state.copyWith(
            errorMessage:
                "There has been an error while getting the current user",
          ));
    }

    return null;
  }

  /// Checks if the user is authenticated.
  ///
  /// This method calls [IsUserAuthenticatedUseCase] to check if the user
  /// is authenticated. It returns true if the user is authenticated,
  /// otherwise false. If there is an error, it updates the state with an error message.
  bool _isUserAuthenticated() {
    final result = _isUserAuthenticatedUseCase.execute();

    if (result.isSuccess) {
      return result.value ?? false;
    }

    if (result.isFailure) {
      _updateState((state) => state.copyWith(
            errorMessage:
                'There has been an error while checking if the user is authenticated',
          ));
    }

    return false;
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
