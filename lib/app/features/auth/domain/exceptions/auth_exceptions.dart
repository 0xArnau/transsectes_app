/// A base interface for authentication-related exceptions.
///
/// All exceptions related to authentication should implement this interface
/// to provide a common type for handling them.
interface class AuthException implements Exception {
  /// A descriptive message about the exception.
  final String message;

  /// Creates an instance of `AuthException` with the given [message].
  AuthException(this.message);

  @override
  String toString() => message;
}

/// An exception thrown when the provided email addresses do not match.
///
/// This exception is typically used to indicate that the email confirmation
/// process has failed.
///
/// Example:
/// ```dart
/// throw IncorrectEmailException('Emails must match');
/// ```
class IncorrectEmailException extends AuthException {
  /// Creates an instance of `IncorrectEmailException` with the given [message].
  IncorrectEmailException(super.message);
}

/// An exception thrown when the provided passwords do not match.
///
/// This exception is typically used to indicate that the password confirmation
/// process has failed.
///
/// Example:
/// ```dart
/// throw IncorrectPasswordException('Passwords must match');
/// ```
class IncorrectPasswordException extends AuthException {
  /// Creates an instance of `IncorrectPasswordException` with the given [message].
  IncorrectPasswordException(super.message);
}

/// An exception thrown when one or more required fields are empty.
///
/// This exception is typically used to indicate that the user has not
/// completed all required input fields.
///
/// Example:
/// ```dart
/// throw EmptyFieldException('Some fields are empty');
/// ```
class EmptyFieldException extends AuthException {
  /// Creates an instance of `EmptyFieldException` with the given [message].
  EmptyFieldException(super.message);
}
