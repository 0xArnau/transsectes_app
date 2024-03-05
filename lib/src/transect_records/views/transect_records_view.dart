import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';

class TransectRecordsView extends StatelessWidget {
  const TransectRecordsView({super.key});

  static const path = '/transect-records';

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: S.current.transect_records,
      body: null,
    );
  }
}
