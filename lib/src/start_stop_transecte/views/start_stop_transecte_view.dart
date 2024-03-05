import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';

class StartStopTransecteView extends StatelessWidget {
  const StartStopTransecteView({super.key});

  static const path = '/start-stop-transect';

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: S.current.start_transect,
      body: null,
    );
  }
}
