import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_all_transects_usecase.dart';

/// ViewModel for managing and processing transect data for charting purposes.
class ChartsViewModel {
  final GetAllTransectsUseCase _getAllTransectsUseCase;

  /// Constructs a [ChartsViewModel] with the provided dependencies.
  ///
  /// - [ref]: The Riverpod [Ref] for dependency injection.
  /// - [getAllTransectsUseCase]: The use case to fetch all transects.
  ChartsViewModel({
    required GetAllTransectsUseCase getAllTransectsUseCase,
  }) : _getAllTransectsUseCase = getAllTransectsUseCase;

  /// A stream of transect data.
  late Stream<List<TransectEntity>> transectsStream;

  /// Initializes the ViewModel by setting up the [transectsStream].
  ///
  /// This method retrieves all transects using the provided use case.
  /// Throws an [Error] if the use case returns an error.
  void init() {
    final result = _getAllTransectsUseCase.execute();

    result.fold(
      (value) => transectsStream = value,
      (error) => throw Error(),
    );
  }

  /// Processes transects to calculate metrics grouped by a specified time range.
  ///
  /// - [transects]: The list of transect entities to process.
  /// - [range]: The grouping range, which can be "year", "month", "week", or "day".
  ///
  /// Returns a map where the keys represent the time group (e.g., "2025", "2025-01")
  /// and the values are maps containing metrics:
  /// - `informedPeople`: Total number of informed people.
  /// - `tractorCount`: Total number of transects with tractor usage.
  /// - `noTractorCount`: Total number of transects without tractor usage.
  ///
  /// Throws an [Exception] if an invalid range is provided.
  Future<Map<String, Map<String, int>>> processMetricsByTimeRange({
    required List<TransectEntity> transects,
    required String range,
  }) async {
    final groupedData = <String, Map<String, int>>{};

    for (final transect in transects) {
      final key = _generateGroupKey(transect, range);
      _initializeGroupData(groupedData, key);
      _updateGroupData(groupedData, key, transect);
    }

    return groupedData;
  }

  /// Generates a grouping key based on the specified range.
  ///
  /// - [transect]: The transect entity to generate the key for.
  /// - [range]: The grouping range, which can be "year", "month", "week", or "day".
  ///
  /// Returns a string representing the grouping key.
  ///
  /// Throws an [Exception] if the range is invalid.
  String _generateGroupKey(TransectEntity transect, String range) {
    final date = transect.createdAt.toDate();

    switch (range) {
      case 'yearly':
        return '${date.year}';
      case 'monthly':
        return '${date.year}-${date.month.toString().padLeft(2, '0')}';
      case 'weekly':
        final week = (date.day - 1) ~/ 7 + 1;
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-W$week';
      case 'daily':
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      default:
        throw Exception('Invalid range: $range');
    }
  }

  /// Initializes group data for a specific key if it does not exist.
  ///
  /// - [groupedData]: The map of grouped data to initialize.
  /// - [key]: The grouping key.
  void _initializeGroupData(
      Map<String, Map<String, int>> groupedData, String key) {
    if (!groupedData.containsKey(key)) {
      groupedData[key] = {
        'numberOfTransects': 0,
        'informedPeople': 0,
        'tractorCount': 0,
        'noTractorCount': 0,
      };
    }
  }

  /// Updates the metrics for a specific group based on a transect.
  ///
  /// - [groupedData]: The map of grouped data to update.
  /// - [key]: The grouping key.
  /// - [transect]: The transect entity to process.
  void _updateGroupData(
    Map<String, Map<String, int>> groupedData,
    String key,
    TransectEntity transect,
  ) {
    groupedData[key]!['numberOfTransects'] =
        (groupedData[key]!['numberOfTransects'] ?? 0) + 1;

    groupedData[key]!['informedPeople'] =
        (groupedData[key]!['informedPeople'] ?? 0) + transect.informedPeople;

    if (transect.tractor) {
      groupedData[key]!['tractorCount'] =
          (groupedData[key]!['tractorCount'] ?? 0) + 1;
    } else {
      groupedData[key]!['noTractorCount'] =
          (groupedData[key]!['noTractorCount'] ?? 0) + 1;
    }
  }
}
