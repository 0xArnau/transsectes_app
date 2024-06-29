import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/colors.dart';

Widget customScaffold({
  required BuildContext context,
  required String title,
  required Widget? body,
  NavigationBar? bottomNavigationBar,
  Widget? drawer,
  List<Widget>? actions,
  bool resizeToAvoidBottomInset = false,
}) {
  return Scaffold(
    backgroundColor: kColorBackground,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    drawer: drawer,
    appBar: AppBar(
      backgroundColor: kColorBackground,
      foregroundColor: kColorTitle,
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions,
    ),
    body: body,
    bottomNavigationBar: bottomNavigationBar,
  );
}
