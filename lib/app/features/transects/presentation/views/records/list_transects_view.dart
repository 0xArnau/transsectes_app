import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListTransectsView extends ConsumerStatefulWidget {
  const ListTransectsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListTransectsViewState();
}

class _ListTransectsViewState extends ConsumerState<ListTransectsView> {
  @override
  Widget build(BuildContext context) {
    return const Text('ListTransectsView');
  }
}
