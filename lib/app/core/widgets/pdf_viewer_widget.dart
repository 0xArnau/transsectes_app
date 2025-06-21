import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:transsectes_app/app/core/providers/detail_pdf_view_model_provider.dart';
import 'package:transsectes_app/app/core/viewmodels/detail_pdf_view_model.dart';
import 'package:transsectes_app/app/core/widgets/float_snackbar.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A view that displays a PDF and allows downloading it to the device.
class PdfViewerWidget extends ConsumerStatefulWidget {
  const PdfViewerWidget({
    super.key,
    required this.title,
    required this.asset,
    required this.fileName,
  });

  static const String path = '/legal/pdf';

  final String title;
  final String asset;
  final String fileName;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PdfViewerWidgetState();
}

class _PdfViewerWidgetState extends ConsumerState<PdfViewerWidget> {
  late DetailPdfViewModel _detailPdfViewModel;

  @override
  void initState() {
    super.initState();
    _detailPdfViewModel = ref.read(detailPdfViewModelProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: '${S.current.download} ${widget.title} PDF',
            onPressed: () => _savePdf(context),
          )
        ],
      ),
      body: SafeArea(
        child: ExcludeSemantics(
          child: SfPdfViewer.asset(widget.asset),
        ),
      ),
    );
  }

  void _savePdf(BuildContext context) async {
    final result = await _detailPdfViewModel.savePdfFromAssets(
      widget.asset,
      widget.fileName,
    );

    result.fold(
      (okMessage) => _showSnackbar(context, okMessage, false),
      (error) => _showSnackbar(context, S.current.errorWhileSavingFile, true),
    );
  }

  void _showSnackbar(BuildContext context, String message, bool isError) {
    if (context.mounted) {
      floatSnackbar(
        context: context,
        message: message,
        isError: isError,
        durationInSeconds: 30,
      );
    }
  }
}
