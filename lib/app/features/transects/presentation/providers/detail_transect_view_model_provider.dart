import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/detail_transect_view_model.dart';

/// Provider for the [DetailTransectViewModel].
///
/// This provider creates an instance of [DetailTransectViewModel] using the
/// [SaveTransectsAsCsvUsecase] retrieved from the `useCaseProviders`.
final detailTransectViewModelProvider =
    Provider<DetailTransectViewModel>((ref) {
  final saveTransectsAsCsvUsecase = ref.read(saveTransectsAsCsvUsecaseProvider);

  return DetailTransectViewModel(
    ref: ref,
    saveTransectsAsCsvUsecase: saveTransectsAsCsvUsecase,
  );
});
