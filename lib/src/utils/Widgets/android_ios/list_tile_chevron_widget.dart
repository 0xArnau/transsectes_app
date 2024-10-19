import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart'
    show CupertinoListTile, CupertinoListTileChevron;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Icon,
        Icons,
        ListTile,
        MaterialPageRoute,
        Navigator,
        StatelessWidget,
        Widget;

class ListTileChevronWidget extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Function goto;

  const ListTileChevronWidget({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    required this.goto,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _listTileIos(context) : _listTileAndroid(context);
  }

  Widget _listTileIos(BuildContext context) {
    return CupertinoListTile.notched(
      leading: leading,
      leadingSize: 65,
      title: title,
      subtitle: subtitle,
      trailing: const CupertinoListTileChevron(),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => goto(),
          ),
        );
      },
    );
  }

  Widget _listTileAndroid(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: const Icon(Icons.open_in_new),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => goto(),
          ),
        );
      },
    );
  }
}
