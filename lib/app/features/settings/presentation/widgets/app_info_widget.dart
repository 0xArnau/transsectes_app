import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:transsectes_app/generated/l10n.dart';

class AppInfoWidget extends StatefulWidget {
  const AppInfoWidget({super.key});

  @override
  State<AppInfoWidget> createState() => _AppInfoWidgetState();
}

class _AppInfoWidgetState extends State<AppInfoWidget> {
  late String appName = '';
  late String version = '';
  late String buildNumber = '';

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  Future<void> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        appName = packageInfo.appName;
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.info_outline,
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      onPressed: () {
        _showAppInfoModal(context);
      },
    );
  }

  /// Displays a modal with the app information.
  void _showAppInfoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title:  Text(S.current.appInfo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _infoTile(context, S.current.appName, appName),
              _infoTile(context, S.current.appVersion, version),
              _infoTile(context, S.current.buildNumber, buildNumber),
              _infoTile(context, S.current.appCreator, S.current.appCreatedBy,),
              _infoTile(
                  context, S.current.appSourceCode, 'github.com/0xArnau/transsectes_app'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the modal
              },
              child: Text(S.current.accept),
            ),
          ],
        );
      },
    );
  }

  /// Helper widget to display a title and subtitle in the app info modal.
  Widget _infoTile(BuildContext context, String title, String subtitle) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: SelectableText(
        subtitle,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
