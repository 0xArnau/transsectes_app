import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
      icon: const Icon(
        Icons.info_outline,
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
          title: const Text('App Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _infoTile(context, 'Name', appName),
              _infoTile(context, 'Version', version),
              _infoTile(context, 'Build Number', buildNumber),
              _infoTile(context, 'Creator', 'Arnau + GePeC-EdC'),
              _infoTile(
                  context, 'Source Code', 'github.com/0xArnau/transsectes_app'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the modal
              },
              child: const Text('Accept'),
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
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: SelectableText(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
