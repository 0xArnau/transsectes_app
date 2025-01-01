import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/auth/presentation/viewmodels/sign_up_view_model.dart';

/// A Riverpod provider for the `SignUpViewModel`.
///
/// This provider is responsible for creating an instance of `SignUpViewModel`
/// by fetching the required dependencies, such as `SignUpUseCase`, from other
/// providers.
///
/// Usage:
/// - Use `ref.read(signUpViewModelProvider)` to access the `SignUpViewModel` instance.
///
/// Dependencies:
/// - `signUpUseCaseProvider`: Provides the `SignUpUseCase` instance.
///
/// Example:
/// ```dart
/// final viewModel = ref.read(signUpViewModelProvider);
/// viewModel.createAccount();
/// ```
final signUpViewModelProvider = Provider<SignUpViewModel>((ref) {
  final signUpUseCase = ref.read(signUpUseCaseProvider);
  return SignUpViewModel(
    ref: ref,
    signUpUseCase: signUpUseCase,
  );
});
