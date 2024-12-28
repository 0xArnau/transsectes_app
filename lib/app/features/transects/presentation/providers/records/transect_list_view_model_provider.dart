import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/records/transect_list_view_model.dart';

/// Provider for the [TransectListViewModel].
///
/// It initializes the ViewModel with the required use cases and dependencies.
final transectListViewModelProvider = Provider<TransectListViewModel>((ref) {
  final getAllTransectsUseCase = ref.read(getAllTransectsUseCaseProvider);
  final getUserTransectsUseCase = ref.read(getUserTransectsUseCaseProvider);

  return TransectListViewModel(
    ref: ref,
    getAllTransectsUseCase: getAllTransectsUseCase,
    getUserTransectsUseCase: getUserTransectsUseCase,
  );
});
