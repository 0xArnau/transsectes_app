import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/auth/presentation/viewmodels/sign_up_view_model.dart';

final signUpViewModelProvider = Provider<SignUpViewModel>((ref) {
  final signUpUseCase = ref.read(signUpUseCaseProvider);
  return SignUpViewModel(
    ref: ref,
    signUpUseCase: signUpUseCase,
  );
});
