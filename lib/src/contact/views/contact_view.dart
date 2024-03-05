import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  static const path = '/contact';

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
        S.current.contact,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
