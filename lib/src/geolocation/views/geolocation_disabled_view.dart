import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';

import '../../../generated/l10n.dart';

class GeolocationDisabledView extends StatelessWidget {
  const GeolocationDisabledView({super.key});

  static const path = '/geolocation-disabled';

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: S.current.gps_service_disabled,
      body: Center(
        child: Text(S.current.gps_services_enable_gps),
      ),
    );
  }
}
