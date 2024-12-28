import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/save_transects_as_csv_usecase.dart';

/// ViewModel responsible for handling the details of a transect.
///
/// The [DetailTransectViewModel] provides methods for interacting with
/// transect data, such as saving a list of transects as a CSV file.
class DetailTransectViewModel {
  /// Reference to the Riverpod container for accessing other providers.
  final Ref ref;

  /// Use case for saving transects as a CSV file.
  final SaveTransectsAsCsvUsecase saveTransectsAsCsvUsecase;

  /// Creates an instance of [DetailTransectViewModel].
  ///
  /// - [ref]: The Riverpod container reference.
  /// - [saveTransectsAsCsvUsecase]: The use case for saving transects as a CSV file.
  DetailTransectViewModel({
    required this.ref,
    required this.saveTransectsAsCsvUsecase,
  });

  /// Saves a list of transects as a CSV file.
  ///
  /// - [reports]: A list of [TransectEntity] objects to be saved.
  /// - [locality]: The locality name to include in the CSV file.
  ///
  /// Returns a [Result] object containing either a success message (String)
  /// or a [DataError] in case of failure.
  Future<Result<String, DataError>> saveTransectsAsCsv(
    List<TransectEntity> reports,
    String locality,
  ) async {
    return saveTransectsAsCsvUsecase.execute(
      reports: reports,
      locality: locality,
    );
  }
}
