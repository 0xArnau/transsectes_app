import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final IconData android;
  final IconData ios;
  final double? size;

  const IconWidget({
    super.key,
    required this.android,
    required this.ios,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Platform.isIOS ? ios : android,
      size: size,
    );
  }
}
