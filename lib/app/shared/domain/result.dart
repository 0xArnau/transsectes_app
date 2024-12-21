/// A class that represents the result of an operation which can either be a success or failure.
///
/// The `Result` class is used to encapsulate the success value or error in an operation,
/// which helps to avoid throwing exceptions and allows for cleaner error handling. It can
/// represent either a successful result with a value or a failed result with an error.
class Result<T, E> {
  /// The value that is returned when the operation is successful.
  final T? value;

  /// The error that is returned when the operation fails.
  final E? error;

  /// Indicates whether the result represents a successful operation.
  bool get isSuccess => error == null;

  /// Indicates whether the result represents a failed operation.
  bool get isFailure => error != null;

  // Private constructor to initialize the result.
  Result._(this.value, this.error);

  /// Creates a successful result with the given [value].
  ///
  /// Example:
  /// ```dart
  /// final result = Result.success("Success");
  /// ```
  factory Result.success(T value) => Result._(value, null);

  /// Creates a failed result with the given [error].
  ///
  /// Example:
  /// ```dart
  /// final result = Result.failure("An error occurred");
  /// ```
  factory Result.failure(E error) => Result._(null, error);
}
