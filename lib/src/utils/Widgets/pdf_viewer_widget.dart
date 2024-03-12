import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';

class PdfViewerWidget extends StatelessWidget {
  const PdfViewerWidget({super.key, required this.title, required this.asset});

  static const String path = '/legal/pdf';

  final String title;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: title,
      body: SafeArea(
        child: SfPdfViewer.asset(asset),
      ),
    );
  }
}
