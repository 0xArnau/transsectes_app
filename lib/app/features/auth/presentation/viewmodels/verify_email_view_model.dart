import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/core/states/user_state.dart';
import 'package:transsectes_app/app/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/is_email_verified_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_out_usecase.dart';

/// A ViewModel responsible for managing email verification logic.
///
/// This class interacts with use cases and manages state updates related
/// to email verification, ensuring the UI reflects the current user
/// authentication status.
class VerifyEmailViewModel {
  /// A reference to the Riverpod `Ref` object, used to read and write state.
  final Ref _ref;

  /// Use case for sending email verification requests.
  final SendEmailVerificationUsecase _sendEmailVerificationUsecase;

  /// Use case for checking if the user's email is verified.
  final IsEmailVerifiedUseCase _isEmailVerifiedUseCase;

  final SignOutUseCase _signOutUseCase;

  /// Creates an instance of [VerifyEmailViewModel].
  ///
  /// - [ref]: A Riverpod `Ref` object for managing state providers.
  /// - [sendEmailVerificationUsecase]: Use case for sending email verification.
  /// - [isEmailVerifiedUseCase]: Use case for verifying if an email is verified.
  VerifyEmailViewModel({
    required Ref ref,
    required SendEmailVerificationUsecase sendEmailVerificationUsecase,
    required IsEmailVerifiedUseCase isEmailVerifiedUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _ref = ref,
        _isEmailVerifiedUseCase = isEmailVerifiedUseCase,
        _sendEmailVerificationUsecase = sendEmailVerificationUsecase,
        _signOutUseCase = signOutUseCase;


    /// Signs the user out.
  ///
  /// This function initiates the sign-out process by calling the [SignOutUseCase].
  /// It updates the state to indicate the loading state while the sign-out request
  /// is being processed. Upon success, the user state is cleared. If the sign-out
  /// fails, an error message is displayed.
  Future<void> signOut() async {
    // Set loading state to true
    _updateState((state) => state.copyWith(
          isLoading: true,
        ));

    // Execute the sign-out use case
    final response = await _signOutUseCase.execute();

    if (response.isSuccess) {
      // Update the state after successful sign out
      Logger().d("signout ok");
      _updateState((state) => state.copyWith(
            isLoading: false,
            user: null,
          ));
      return;
    }

    // Update the state with an error message if sign-out fails
    _updateState((state) => state.copyWith(
        isLoading: false, errorMessage: 'Cannot sign out. Please try again'));
  }

  /// Sends an email verification to the current user's email.
  ///
  /// This method triggers the email verification process using
  /// [_sendEmailVerificationUsecase].
  ///
  /// Throws:
  /// - [AuthException] if there is an error during the process.
  Future<void> sendEmail() async {
    await _sendEmailVerificationUsecase.execute();
  }

  /// Reloads the user's email verification status and updates the state.
  ///
  /// This method checks whether the user's email is verified by calling
  /// [_isEmailVerifiedUseCase] and updates the [currentUserStateProvider].
  ///
  /// Throws:
  /// - [AuthException] if an unknown error occurs during the reload process.
  Future<void> reload() async {
    // Email parameter is not necessary
    final response = await _isEmailVerifiedUseCase.execute('');

    response.fold(
      (value) => _updateState(
        (state) {
          final user = state.user?.copyWith(isEmailVerified: value);
          return state.copyWith(user: user);
        },
      ),
      (_) => throw AuthException('Unknown error, cannot reload'),
    );
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
