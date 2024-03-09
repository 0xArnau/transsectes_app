import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:transsectes_app/src/auth/widgets/log_out_widget.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  late String appName = '';
  late String version = '';
  late String buildNumber = '';

  @override
  void initState() {
    super.initState();

    _getPackageInfo();
  }

  _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kColorBackground,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [],
              ),
            ),
            Center(
              child: Column(
                children: [
                  logOutWidget(),
                  Text(
                    '$appName - $version($buildNumber)',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
