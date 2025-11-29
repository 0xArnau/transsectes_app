import 'package:flutter_riverpod/legacy.dart';

/// Provider for tracking the error state during the save transect operation.
///
/// This state provider holds a boolean value:
/// - `true`: Indicates an error occurred during the save operation.
/// - `false`: Indicates no error.
final saveTransectErrorStateProvider = StateProvider((ref) => false);
