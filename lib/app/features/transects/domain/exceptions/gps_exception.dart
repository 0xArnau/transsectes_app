/// Represents a generic exception related to GPS operations.
///
/// This class serves as a base for specific GPS-related exceptions and
/// implements the [Exception] interface to integrate seamlessly with Dart's
/// error handling mechanisms.
class GpsException implements Exception {
  /// A descriptive message providing details about the exception.
  final String message;

  /// Creates a [GpsException] with the provided [message].
  ///
  /// The [message] should clearly describe the cause of the exception,
  /// making it easier to diagnose and handle.
  GpsException(this.message);

  @override
  String toString() => message;
}

/// Represents an exception thrown when GPS permissions are permanently denied.
///
/// This exception is intended to be used in scenarios where the user has
/// permanently denied GPS permissions, requiring them to manually enable
/// permissions from the device settings.
class PermanentlyDeniedException extends GpsException {
  /// Creates a [PermanentlyDeniedException] with the provided [message].
  ///
  /// The [message] should specify the reason or context for the exception,
  /// such as instructions for the user to re-enable permissions.
  PermanentlyDeniedException(super.message);
}

/// Represents an exception thrown when the GPS service is disabled.
///
/// This exception is thrown when the GPS service is turned off or unavailable,
/// indicating that the application cannot access location services.
class GpsServiceDisabled extends GpsException {
  /// Creates a [GpsServiceDisabled] exception with the provided [message].
  ///
  /// The [message] should describe the state of the GPS service (e.g., turned off)
  /// and guide the user on how to enable the service if necessary.
  GpsServiceDisabled(super.message);
}
