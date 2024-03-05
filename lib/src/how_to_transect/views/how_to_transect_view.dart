import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';

class HowToTransectView extends StatelessWidget {
  const HowToTransectView({super.key});

  static const path = '/how-to-transect';

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: S.current.how2transect,
      body: null,
    );
  }
}
