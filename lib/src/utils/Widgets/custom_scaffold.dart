import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/colors.dart';

Widget customScaffold({
  required BuildContext context,
  required String title,
  required Widget? body,
  Widget? drawer,
}) {
  return Scaffold(
    backgroundColor: kColorBackground,
    drawer: drawer,
    appBar: AppBar(
      backgroundColor: kColorBackground,
      foregroundColor: kColorTitle,
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    body: body,
  );
}
