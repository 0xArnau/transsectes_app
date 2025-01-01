import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/core/states/user_state.dart';
import 'package:transsectes_app/app/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// ViewModel for handling user sign-up logic.
///
/// The [SignUpViewModel] is responsible for validating user credentials
/// (email and password) and handling account creation through the
/// associated [SignUpUseCase].
class SignUpViewModel {
  /// The provider reference, which allows access to other providers.
  final Ref _ref;

  /// The use case responsible for signing up a user.
  final SignUpUseCase _signUpUseCase;

  /// Creates an instance of [SignUpViewModel] with the provided [ref] and [signUpUseCase].
  ///
  /// The [ref] is used to access other providers within the Riverpod ecosystem.
  /// The [signUpUseCase] is responsible for performing the sign-up process.
  SignUpViewModel({
    required Ref ref,
    required SignUpUseCase signUpUseCase,
  })  : _ref = ref,
        _signUpUseCase = signUpUseCase;

  /// Creates a new user account.
  ///
  /// This method is responsible for invoking the sign-up use case.
  /// As of now, this method is a placeholder and does not perform any actions.
  Future<void> createAccount({
    required String email,
    required String emailCopy,
    required String password,
    required String passwordCopy,
    required bool avis,
    required bool clausulaInformativa,
    required bool privacitat,
  }) async {
    validateCredentials(
      email: email,
      emailCopy: emailCopy,
      password: password,
      passwordCopy: passwordCopy,
    );

    validateLegal(avis, clausulaInformativa, privacitat);

    final response = await _signUpUseCase.execute(email, password);

    Logger().d(response.value?.toString());

    response.fold(
      (entity) => _updateState(
        (state) => state.copyWith(isLoading: false, user: entity),
      ),
      (_) => throw AuthException('Unknown error, cannot create user account'),
    );
  }

  /// Validates the user credentials (email and password).
  ///
  /// This method checks that none of the fields are empty and that the email and
  /// password fields match the confirmation fields.
  ///
  /// [email] The email entered by the user.
  /// [emailCopy] The email confirmation entered by the user.
  /// [password] The password entered by the user.
  /// [passwordCopy] The password confirmation entered by the user.
  ///
  /// Throws [EmptyFieldException] if any field is empty.
  /// Throws [IncorrectEmailException] if the email addresses do not match.
  /// Throws [IncorrectPasswordException] if the passwords do not match.
  void validateCredentials({
    required String email,
    required String emailCopy,
    required String password,
    required String passwordCopy,
  }) {
    if (email.isEmpty ||
        emailCopy.isEmpty ||
        password.isEmpty ||
        passwordCopy.isEmpty) {
      throw EmptyFieldException('Some fields are empty');
    }

    _validateEmail(email, emailCopy);
    _validatePassword(password, passwordCopy);
  }

  /// Validates that the email addresses match.
  ///
  /// [a] The first email entered by the user.
  /// [b] The second email entered by the user (confirmation).
  ///
  /// Throws [IncorrectEmailException] if the email addresses do not match.
  void _validateEmail(String a, String b) {
    if (a != b) throw IncorrectEmailException('Emails must be the same');
  }

  /// Validates that the password fields match.
  ///
  /// [a] The first password entered by the user.
  /// [b] The second password entered by the user (confirmation).
  ///
  /// Throws [IncorrectPasswordException] if the passwords do not match.
  void _validatePassword(String a, String b) {
    if (a != b) throw IncorrectPasswordException('Password must be the same');
  }

  void validateLegal(bool a, bool b, bool c) {
    if (!a || !b || !c) {
      throw EmptyFieldException('All legal fields mut be accepted');
    }
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
