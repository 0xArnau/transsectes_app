import 'package:transsectes_app/app/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/forgot_password_usecase.dart';

/// ViewModel responsible for handling the logic related to password recovery.
class ForgotPasswordViewModel {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  /// Constructor for initializing the [ForgotPasswordViewModel] with the necessary use case.
  ForgotPasswordViewModel({
    required ForgotPasswordUseCase forgotPasswordUseCase,
  }) : _forgotPasswordUseCase = forgotPasswordUseCase;

  /// Sends a password reset email to the given [email].
  ///
  /// If the email is sent successfully, nothing happens. Otherwise, an error is thrown.
  ///
  /// [email] The email address to which the password reset email will be sent.
  Future<void> sendEmail(String email) async {
    final result = await _forgotPasswordUseCase.execute(email);
    result.fold(
      (_) {},
      (_) => throw AuthException(
        'Unexpected error. Cannot send email to restore password',
      ),
    );
  }
}
