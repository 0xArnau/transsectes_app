abstract interface class AuthException implements Exception {}

class IncorrectEmailException implements AuthException {
  final String message;
  IncorrectEmailException(this.message);

  @override
  String toString() => 'IncorrectEmailException: $message';
}

class IncorrectPasswordException implements AuthException {
  final String message;
  IncorrectPasswordException(this.message);

  @override
  String toString() => 'IncorrectPasswordException: $message';
}
