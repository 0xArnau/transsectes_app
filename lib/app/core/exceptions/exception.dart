/// Exception thrown when the user needs to reauthenticate before performing
/// a sensitive operation such as deleting an account.
class RequiresRecentLoginException implements Exception {
  final String message;
  RequiresRecentLoginException(this.message);

  @override
  String toString() => message;
}

/// Exception thrown for other unexpected errors during the account deletion process.
class DeleteUserAccountException implements Exception {
  final String message;
  DeleteUserAccountException(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when the action is performed by a technician and can only be performed by a non-technician
class RequiresNonTechnicianException implements Exception {
  final String message;
  RequiresNonTechnicianException(this.message);

  @override
  String toString() => message;
}
