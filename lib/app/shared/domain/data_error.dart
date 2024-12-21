/// Represents a data-related error, extending the generic [Error] interface.
abstract class DataError extends Error {
  DataError();
}

/// Remote-related errors in the data layer.
class RemoteError extends DataError {
  final RemoteErrorType type;

  RemoteError(this.type);
}

/// Local-related errors in the data layer.
class LocalError extends DataError {
  final LocalErrorType type;

  LocalError(this.type);
}

/// User-related errors in the data layer.
class UserError extends DataError {
  final UserErrorType type;

  UserError(this.type);
}

/// Enum for remote-related errors.
enum RemoteErrorType {
  requestTimeout,
  tooManyRequests,
  noInternet,
  server,
  serialization,
  unknown,
}

/// Enum for local-related errors.
enum LocalErrorType {
  diskFull,
  unknown,
}

/// Enum for user-related errors.
enum UserErrorType {
  userNotFound,
  emailNotFound,
}
