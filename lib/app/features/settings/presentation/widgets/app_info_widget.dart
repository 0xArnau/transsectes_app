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
  bool _isExpanded = false;

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
    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.onSurface,
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(
              'App Info',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            trailing: Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  _infoTile(context, 'App Name', appName),
                  _infoTile(context, 'Version', version),
                  _infoTile(context, 'Build Number', buildNumber),
                  _infoTile(context, 'Creator', 'Arnau + GePeC-EdC'),
                  _infoTile(context, 'Source Code',
                      'github.com/0xArnau/transsectes_app'),
                ],
              ),
            ),
        ],
      ),
    );
  }

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
