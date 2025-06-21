import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// Abstract class defining the contract for the File Repository.
///
/// This repository is responsible for handling file-related operations, such as
/// saving a list of transect reports as CSV files. It abstracts away the
/// underlying implementation details, allowing different data sources or services
/// to be used to perform these operations.
abstract class FileRepository {
  /// Saves a list of transect reports as a CSV file.
  ///
  /// The [reports] parameter is a list of [TransectEntity] objects that need
  /// to be saved in CSV format.
  ///
  /// The [locality] parameter is a string representing the locality name,
  /// which will typically be used for the file name or any filtering necessary
  /// during the saving process.
  ///
  /// The method returns a [Result] object:
  /// - On success, it returns a [Result.success] containing the file path or URL
  ///   as a string.
  /// - On failure, it returns a [Result.failure] with a [DataError] describing
  ///   the problem.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await fileRepository.saveReportsAsCsv(
  ///   reports: transectsList,
  ///   locality: 'LocalityName'
  /// );
  /// if (result.isSuccess) {
  ///   print('File saved at: ${result.getValue()}');
  /// } else {
  ///   print('Error: ${result.getError().message}');
  /// }
  /// ```
  Future<Result<String, DataError>> saveReportsAsCsv({
    required List<TransectEntity> reports,
    required String locality,
  });

  /// Saves a PDF file that is bundled in the app's assets.
  ///
  /// [assetPath] is the path to the asset in the project (e.g., 'assets/docs/legal/terms.pdf').
  /// [fileName] is the desired name of the file when saved to the device.
  ///
  /// Returns a [Result] with a success message or a [DataError] on failure.
  Future<Result<String, DataError>> savePdfFromAssets({
    required String assetPath,
    required String fileName,
  });
}
