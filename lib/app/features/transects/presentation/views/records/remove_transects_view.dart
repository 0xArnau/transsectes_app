import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoveTransectsView extends ConsumerStatefulWidget {
  const RemoveTransectsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RemoveTransectsViewState();
}

class _RemoveTransectsViewState extends ConsumerState<RemoveTransectsView> {
  @override
  Widget build(BuildContext context) {
    return const Text('RemoveTransectsView');
  }
}
