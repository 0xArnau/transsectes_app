import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final Function? onTap;

  const ListTileWidget(
      {super.key,
      this.leading,
      required this.title,
      this.subtitle,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _listTileIos() : _listTileAndroid();
  }

  Widget _listTileIos() {
    return CupertinoListTile.notched(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: () => onTap,
    );
  }

  Widget _listTileAndroid() {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: () => onTap,
    );
  }
}
