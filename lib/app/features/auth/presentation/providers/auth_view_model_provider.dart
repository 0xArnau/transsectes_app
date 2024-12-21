import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:transsectes_app/app/shared/presentation/providers/use_case_providers.dart';

/// A Riverpod provider for the AuthViewModel.
///
/// This provider creates an instance of [AuthViewModel] by reading the necessary use cases
/// from the provider container and passing them to the view model's constructor.
final authViewModelProvider = Provider<AuthViewModel>((ref) {
  final getCurrentUserUseCase = ref.read(getCurrentUserUseCaseProvider);
  final isUserAuthenticatedUseCase =
      ref.read(isUserAuthenticatedUseCaseProvider);
  return AuthViewModel(
    ref: ref,
    isUserAuthenticatedUseCase: isUserAuthenticatedUseCase,
    getCurrentUserUseCase: getCurrentUserUseCase,
  );
});
