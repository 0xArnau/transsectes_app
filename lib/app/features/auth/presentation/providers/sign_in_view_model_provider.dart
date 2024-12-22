import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/auth/presentation/viewmodels/sign_in_view_model.dart';

/// A Riverpod provider for the AuthViewModel.
///
/// This provider creates an instance of [AuthViewModel] by reading the necessary use cases
/// from the provider container and passing them to the view model's constructor.
final signinViewModelProvider = Provider<SignInViewModel>((ref) {
  final signInUseCase = ref.read(signInUseCaseProvider);
  return SignInViewModel(
    ref: ref,
    signInUseCase: signInUseCase,
  );
});
