/// Interface for handling location permissions.
///
/// This interface defines methods for requesting permissions to access the
/// location (foreground and background) and ensuring that GPS is enabled.
abstract class PermissionDataSource {
  /// Requests permission for accessing location while the app is in the foreground.
  ///
  /// Returns `true` if permission is granted, otherwise `false`.
  Future<bool> requestLocationForegroundPermission();

  /// Requests permission for accessing location in the background.
  ///
  /// Returns `true` if permission is granted, otherwise `false`.
  Future<bool> requestLocationBackgroundPermission();

  /// Requests permission to access the device's location.
  ///
  /// Returns `true` if permission is granted, otherwise `false`.
  Future<bool> requestLocationPermission();

  /// Checks and requests for enabling GPS service.
  ///
  /// Returns `true` if GPS is enabled, otherwise `false`.
  Future<bool> requestGpsServiceEnabled();
}
