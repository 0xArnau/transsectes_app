import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';

/// A use case for sending an email verification to the current user.
///
/// This use case is responsible for invoking the repository method that
/// triggers the email verification process for the currently authenticated user.
class SendEmailVerificationUsecase {
  /// The repository responsible for handling user authentication and account operations.
  final AuthRepository repository;

  /// Creates an instance of [SendEmailVerificationUsecase].
  ///
  /// [repository] must be an instance of [AuthRepository], which provides
  /// the functionality to send email verification requests.
  SendEmailVerificationUsecase(this.repository);

  /// Executes the use case to send an email verification.
  ///
  /// This method calls the repository to send a verification email to the
  /// currently authenticated user's email address.
  ///
  /// Throws:
  /// - [AuthException] if an error occurs during the email verification process.
  /// - Any other exceptions defined by the repository.
  ///
  /// Example:
  /// ```dart
  /// final usecase = SendEmailVerificationUsecase(authRepository);
  /// await usecase.execute();
  /// ```
  Future<void> execute() async {
    return await repository.verifyEmailForCurrentUser();
  }
}
