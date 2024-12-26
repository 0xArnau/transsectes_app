import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// Abstract class that defines the contract for saving reports as CSV files.
///
/// This class is responsible for defining the method to save a list of transect
/// reports in a CSV format, given a list of reports and a locality name.
abstract class FileDatasource {
  /// Saves a list of transect reports as a CSV file.
  ///
  /// The [reports] parameter should contain a list of [TransectEntity] objects
  /// that need to be saved in the CSV format.
  ///
  /// The [locality] parameter represents the locality name, which will be used
  /// as part of the CSV file name or for any filtering necessary while saving.
  ///
  /// This method returns a [Result] that wraps either a [void] on success
  /// or a [DataError] in case of failure. The [Result] type provides a way
  /// to handle success and failure scenarios.
  ///
  /// Throws an [Exception] if an error occurs during the file saving process.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await fileDatasource.saveReportsAsCsv(
  ///   reports: transectsList,
  ///   locality: 'LocalityName'
  /// );
  ///
  /// result.when(
  ///   success: (_) {},
  ///   failure: (error) {},
  /// );
  /// ```
  Future<Result<String, DataError>> saveReportsAsCsv({
    required List<TransectEntity> reports,
    required String locality,
  });
}
