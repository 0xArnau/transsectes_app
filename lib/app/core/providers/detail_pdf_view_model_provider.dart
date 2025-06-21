import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/use_case_providers.dart';
import 'package:transsectes_app/app/core/viewmodels/detail_pdf_view_model.dart';

/// Provider for the [DetailPdfViewModel].
final detailPdfViewModelProvider = Provider<DetailPdfViewModel>((ref) {
  final savePdfFromAssetsUsecase = ref.read(savePDFFromAssetsUsecaseProvider);

  return DetailPdfViewModel(
    ref: ref,
    savePdfFromAssetsUsecase: savePdfFromAssetsUsecase,
  );
});
