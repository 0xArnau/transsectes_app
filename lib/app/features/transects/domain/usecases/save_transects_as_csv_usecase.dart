import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/file_repository.dart';

/// Use case responsible for saving transect reports as a CSV file.
///
/// This class serves as a mediator between the domain and data layer. It handles
/// the logic for saving a list of transect reports as a CSV file using the
/// `FileRepository` abstraction. It delegates the task to the repository and
/// returns the result.
class SaveTransectsAsCsvUsecase {
  final FileRepository fileRepository;

  /// Creates an instance of [SaveTransectsAsCsvUsecase].
  ///
  /// This constructor takes a [FileRepository] as a dependency, which is used
  /// to interact with the underlying data storage mechanism to save the reports
  /// as a CSV file.
  ///
  /// [fileRepository]: The repository responsible for saving the reports.
  SaveTransectsAsCsvUsecase(this.fileRepository);

  /// Executes the use case to save transect reports as a CSV file.
  ///
  /// This method takes a list of [TransectEntity] objects and a locality name,
  /// and it invokes the repository to perform the saving operation.
  ///
  /// The method returns a [Result] that indicates the success or failure of
  /// the operation:
  /// - On success, it returns a [Result.success] with the file path or URL
  ///   where the CSV file was saved.
  /// - On failure, it returns a [Result.failure] containing a [DataError]
  ///   indicating the issue that occurred.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await saveTransectsAsCsvUsecase.execute(
  ///   reports: transectsList,
  ///   locality: 'LocalityName'
  /// );
  /// if (result.isSuccess) {
  ///   print('File saved at: ${result.getValue()}');
  /// } else {
  ///   print('Error: ${result.getError().message}');
  /// }
  /// ```
  Future<Result<String, DataError>> execute({
    required List<TransectEntity> reports,
    required String locality,
  }) {
    return fileRepository.saveReportsAsCsv(
      reports: reports,
      locality: locality,
    );
  }
}
