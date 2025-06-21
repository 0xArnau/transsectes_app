import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/save_pdf_from_assets_usecase.dart';

/// ViewModel responsible for saving a PDF from assets.
class DetailPdfViewModel {
  /// Reference to the Riverpod container.
  final Ref ref;

  /// Use case for saving PDF from assets.
  final SavePDFFromAssetsUsecase savePdfFromAssetsUsecase;

  /// Creates an instance of [DetailPdfViewModel].
  DetailPdfViewModel({
    required this.ref,
    required this.savePdfFromAssetsUsecase,
  });

  /// Saves a PDF file from the app's assets.
  ///
  /// - [assetPath]: Path to the PDF in the assets folder.
  /// - [fileName]: Desired file name for saving.
  ///
  /// Returns a [Result] with the file location or [DataError].
  Future<Result<String, DataError>> savePdfFromAssets(
    String assetPath,
    String fileName,
  ) async {
    return savePdfFromAssetsUsecase.execute(
      assetPath: assetPath,
      fileName: fileName,
    );
  }
}
