import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyGpsPermissionsView extends ConsumerStatefulWidget {
  const VerifyGpsPermissionsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyGpsPermissionsViewState();
}

class _VerifyGpsPermissionsViewState
    extends ConsumerState<VerifyGpsPermissionsView> {
  @override
  Widget build(BuildContext context) {
    return _gpsWidget();
  }

  Widget _gpsWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify GPS permissions'),
      ),
    );
  }
}
