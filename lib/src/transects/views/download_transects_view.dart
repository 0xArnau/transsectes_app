import 'package:flutter/material.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';

class DownloadTransectsView extends StatefulWidget {
  final Stream<List<TransectModel>> transects;

  const DownloadTransectsView({
    super.key,
    required this.transects,
  });

  @override
  State<DownloadTransectsView> createState() =>
      _DownloadTransectsViewState(transects);
}

class _DownloadTransectsViewState extends State<DownloadTransectsView> {
  final Stream<List<TransectModel>> transects;

  _DownloadTransectsViewState(this.transects);

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
