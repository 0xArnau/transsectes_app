import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/remove_all_transects_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/update_transect_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

class TransectViewModel {
  final Ref _ref;
  final UpdateTransectUseCase _updateTransectUseCase;
  final RemoveAllTransectsUseCase _removeAllTransectsUseCase;

  // The error message that will be shown in the view (via snackbar)
  String? errorMessage;

  // List of TransectEntities to be displayed in the view
  List<TransectEntity> transects = [];

  TransectViewModel({
    required Ref ref,
    required UpdateTransectUseCase updateTransectUseCase,
    required RemoveAllTransectsUseCase removeAllTransectsUseCase,
  })  : _ref = ref,
        _updateTransectUseCase = updateTransectUseCase,
        _removeAllTransectsUseCase = removeAllTransectsUseCase;

  /// Calls the update transect use case and updates errorMessage on failure.
  Future<void> updateTransect(TransectEntity transect) async {
    final result = await _updateTransectUseCase.execute(transect);

    result.fold(
      (value) {},
      (error) {
        errorMessage = 'Failed to update transect: $error';
      },
    );
  }

  /// Calls the remove all transects use case and updates errorMessage on failure.
  Future<void> removeAllTransects() async {
    final result = await _removeAllTransectsUseCase.execute();

    result.fold(
      (value) {
        transects = []; // Clear the list when all transects are removed
      },
      (error) {
        errorMessage = 'Failed to remove all transects: $error';
      },
    );
  }
}
