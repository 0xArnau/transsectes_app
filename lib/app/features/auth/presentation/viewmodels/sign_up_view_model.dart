import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_up_usecase.dart';

class SignUpViewModel {
  final Ref _ref;
  final SignUpUseCase _signUpUseCase;

  SignUpViewModel({
    required Ref ref,
    required SignUpUseCase signUpUseCase,
  })  : _ref = ref,
        _signUpUseCase = signUpUseCase;

  Future<void> createAccount() async {}

  void validateCredentials({
    required String email,
    required String emailCopy,
    required String password,
    required String passwordCopy,
  }) {
    _validateEmail(email, emailCopy);
    _validatePassword(password, passwordCopy);
  }

  void _validateEmail(String a, String b) {
    if (a != b) throw IncorrectEmailException('Emails must be the same');
  }

  void _validatePassword(String a, String b) {
    if (a != b) throw IncorrectPasswordException('Password must be the same');
  }
}
