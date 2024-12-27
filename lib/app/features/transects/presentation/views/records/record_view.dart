import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/records/download_transects_view.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/records/list_transects_view.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/records/remove_transects_view.dart';
import 'package:transsectes_app/generated/l10n.dart';

class RecordView extends ConsumerStatefulWidget {
  const RecordView({super.key});

  static const path = '/transect-recoirds';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecordViewState();
}

class _RecordViewState extends ConsumerState<RecordView> {
  bool isTechnician = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _updateIsTechnicianValue();
  }

  /// Updates the isTechnician value based on the user's data.
  void _updateIsTechnicianValue() {
    if (mounted) {
      setState(() {
        isTechnician =
            ref.read(currentUserStateProvider).user?.isTechnician ?? false;
      });
    }
  }

  /// Builds the BottomNavigationBar for technician users using Material 3's NavigationBar.
  NavigationBar _buildNavigationBar() {
    return NavigationBar(
      selectedIndex: currentPage,
      onDestinationSelected: (index) {
        setState(() {
          currentPage = index;
        });
      },
      destinations: [
        NavigationDestination(
          icon: Icon(currentPage == 0 ? Icons.person : Icons.person_outline),
          label: S.current.transects,
        ),
        NavigationDestination(
          icon: Icon(currentPage == 1 ? Icons.people : Icons.people_outline),
          label: S.current.all_transects,
        ),
        NavigationDestination(
          icon:
              Icon(currentPage == 2 ? Icons.download : Icons.download_outlined),
          label: S.current.download,
        ),
        NavigationDestination(
          icon: const Icon(Icons.highlight_remove),
          label: S.current.remove,
        ),
      ],
    );
  }

  /// Builds the appropriate pages to display based on the technician status.
  List<Widget> _buildPages() {
    if (isTechnician) {
      return [
        const ListTransectsView(key: ValueKey(1)),
        const ListTransectsView(key: ValueKey(2), viewAll: true),
        const DownloadTransectsView(),
        const RemoveTransectsView(),
      ];
    } else {
      return [const ListTransectsView(key: ValueKey(1))];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.transect_records),
      ),
      body: _buildPages()[currentPage],
      bottomNavigationBar: isTechnician ? _buildNavigationBar() : null,
    );
  }
}
