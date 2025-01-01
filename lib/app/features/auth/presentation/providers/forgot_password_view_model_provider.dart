import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/auth/presentation/viewmodels/forgot_password_view_model.dart';

/// A provider that creates and provides the [ForgotPasswordViewModel].
///
/// The provider is responsible for reading the necessary use case and initializing the view model.
final forgotPasswordViewModelProvider =
    Provider<ForgotPasswordViewModel>((ref) {
  final forgotPasswordUseCase = ref.read(forgotPasswordUseCaseProvider);
  return ForgotPasswordViewModel(
    forgotPasswordUseCase: forgotPasswordUseCase,
  );
});
