import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/auth/presentation/viewmodels/verify_email_view_model.dart';

/// A Riverpod provider for the [VerifyEmailViewModel].
///
/// This provider initializes the [VerifyEmailViewModel] by injecting the required
/// dependencies from other providers.
///
/// The following dependencies are read:
/// - [sendEmailVerificationUsecaseProvider]: Provides the use case for sending
///   email verification.
/// - [isEmailVerifiedUseCaseProvider]: Provides the use case for checking if
///   the email is verified.
///
/// Example usage:
/// ```dart
/// final viewModel = ref.read(verifyEmailViewModelProvider);
/// await viewModel.sendEmail();
/// ```
///
/// This provider ensures that the [VerifyEmailViewModel] is constructed with
/// the appropriate use cases and state management tools.
final verifyEmailViewModelProvider = Provider<VerifyEmailViewModel>((ref) {
  final sendEmailVerificationUsecase =
      ref.read(sendEmailVerificationUsecaseProvider);
  final isEmailVerifiedUseCase = ref.read(isEmailVerifiedUseCaseProvider);

  return VerifyEmailViewModel(
    ref: ref,
    sendEmailVerificationUsecase: sendEmailVerificationUsecase,
    isEmailVerifiedUseCase: isEmailVerifiedUseCase,
  );
});
