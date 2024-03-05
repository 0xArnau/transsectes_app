import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class HowToTransectView extends StatelessWidget {
  const HowToTransectView({super.key});

  static const path = '/how-to-transect';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      appBar: _buildAppBar(),
      body: null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: kColorBackground,
      foregroundColor: kColorTitle,
      title: Text(
        S.current.how2transect,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
