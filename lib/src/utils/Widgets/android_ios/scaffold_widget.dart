import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart'
    show
        BuildContext,
        Container,
        CupertinoNavigationBar,
        CupertinoPageScaffold,
        CupertinoTabScaffold,
        MainAxisSize,
        Row;
import 'package:flutter/material.dart'
    show AppBar, Scaffold, Text, TextOverflow, Widget;
import 'package:transsectes_app/src/utils/colors.dart';

Widget scaffoldWidget({
  required BuildContext context,
  required String title,
  required Widget? body,
  Widget? bottomNavigationBar,
  CupertinoTabScaffold? cts,
  Widget? drawer,
  List<Widget>? actions,
  bool resizeToAvoidBottomInset = false,
}) {
  return Platform.isIOS
      ? cts != null
          ? _tabScaffoldIos(
              context: context,
              title: title,
              body: body,
              bottomNavigationBar: cts,
              actions: actions,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            )
          : _scaffoldIos(
              context: context,
              title: title,
              body: body,
              actions: actions,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            )
      : _scaffoldAndroid(
          context: context,
          title: title,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          drawer: drawer,
          actions: actions,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        );
}

Widget _scaffoldAndroid({
  required BuildContext context,
  required String title,
  required Widget? body,
  Widget? bottomNavigationBar,
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

Widget _scaffoldIos({
  required BuildContext context,
  required String title,
  required Widget? body,
  List<Widget>? actions,
  bool resizeToAvoidBottomInset = false,
}) {
  return CupertinoPageScaffold(
    // backgroundColor: kColorBackground,
    navigationBar: CupertinoNavigationBar(
      // backgroundColor: kColorBackground,
      middle: Text(
        title,
        // style: const TextStyle(color: kColorTitle),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions ?? [],
      ),
    ),
    child: Scaffold(body: body ?? Container()),
  );
}

Widget _tabScaffoldIos({
  required BuildContext context,
  required String title,
  required Widget? body,
  required CupertinoTabScaffold bottomNavigationBar,
  List<Widget>? actions,
  bool resizeToAvoidBottomInset = false,
}) {
  return Scaffold(
    appBar: CupertinoNavigationBar(
      middle: Text(
        title,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions ?? [],
      ),
    ),
    body: bottomNavigationBar,
  );
}
