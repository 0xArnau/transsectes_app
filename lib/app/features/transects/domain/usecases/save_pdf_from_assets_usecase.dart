import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/file_repository.dart';

/// Use case responsible for saving a PDF file from the app's bundled assets.
///
/// This class handles the logic of accessing a PDF located in the assets folder
/// and saving it to the device using the [FileRepository] abstraction.
class SavePDFFromAssetsUsecase {
  final FileRepository fileRepository;

  /// Creates an instance of [SavePDFFromAssetsUsecase].
  ///
  /// [fileRepository] is the repository responsible for performing file operations.
  SavePDFFromAssetsUsecase(this.fileRepository);

  /// Executes the use case to save the specified PDF from assets.
  ///
  /// [assetPath] is the relative path to the PDF in the assets directory.
  /// [fileName] is the desired file name to save the PDF as on the device.
  ///
  /// Returns a [Result] with the success message or a [DataError] on failure.
  ///
  /// Example usage:
  /// ```dart
  /// final result = await savePdfFromAssetsUsecase.execute(
  ///   assetPath: 'assets/docs/legal/terms.pdf',
  ///   fileName: 'terms_and_conditions.pdf',
  /// );
  /// if (result.isSuccess) {
  ///   print('PDF saved at: ${result.getValue()}');
  /// } else {
  ///   print('Error: ${result.getError().message}');
  /// }
  /// ```
  Future<Result<String, DataError>> execute({
    required String assetPath,
    required String fileName,
  }) {
    return fileRepository.savePdfFromAssets(
      assetPath: assetPath,
      fileName: fileName,
    );
  }
}
