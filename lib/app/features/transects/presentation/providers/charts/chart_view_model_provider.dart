import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/charts/charts_view_model.dart';

/// A provider for [ChartsViewModel].
///
/// This provider is responsible for creating and providing an instance of [ChartsViewModel].
/// It reads the [getAllTransectsUseCaseProvider] to obtain the use case needed for
/// fetching all transects data and then uses it to instantiate the [ChartsViewModel].
final chartsViewModelProvider = Provider<ChartsViewModel>((ref) {
  // Reading the getAllTransectsUseCaseProvider from the Riverpod container.
  final getAllTransectsUseCase = ref.read(getAllTransectsUseCaseProvider);

  // Returning the ChartsViewModel with the necessary use case injected.
  return ChartsViewModel(
    getAllTransectsUseCase: getAllTransectsUseCase,
  );
});
