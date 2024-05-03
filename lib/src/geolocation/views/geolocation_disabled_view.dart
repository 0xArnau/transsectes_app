import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';

class GeolocationDisabledView extends StatelessWidget {
  const GeolocationDisabledView({super.key});

  static const path = '/geolocation-disabled';

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: 'GPS services is disabled',
      body: const Center(
        child: Text("Enable GPS service and go back"),
      ),
    );
  }
}
