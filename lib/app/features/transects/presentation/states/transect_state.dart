import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

part 'transect_state.freezed.dart';

/// Represents the state of the transects feature.
///
/// It contains the list of transects, loading state, success message, and error message.
@freezed
class TransectState with _$TransectState {
  const factory TransectState({
    required List<TransectEntity> transects, // The list of transects
    required bool isLoading, // Whether the data is still loading
    required String? okMessage, // Success message, if any
    required String? errorMessage, // Error message, if any
  }) = _TransectState;

  /// Returns the initial state for the transects feature.
  ///
  /// The initial state represents the state when no action has occurred yet.
  factory TransectState.initial() => const TransectState(
        isLoading: false,
        transects: [],
        okMessage: null,
        errorMessage: null,
      );
}
