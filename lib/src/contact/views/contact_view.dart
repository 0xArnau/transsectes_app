import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  static const path = '/contact';

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: S.current.contact,
      body: null,
    );
  }
}
