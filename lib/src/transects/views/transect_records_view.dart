import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/transects/repositories/tecnics/tecnic_repository.dart';
import 'package:transsectes_app/src/transects/views/all_transects_view.dart';
import 'package:transsectes_app/src/transects/views/download_transects_view.dart';
import 'package:transsectes_app/src/transects/views/user_transects_view.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class TransectRecordsView extends StatefulWidget {
  const TransectRecordsView({super.key});

  static const path = '/transect-records';

  @override
  State<TransectRecordsView> createState() => _TransectRecordsViewState();
}

class _TransectRecordsViewState extends State<TransectRecordsView> {
  bool technician = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    TecnicRepository().isTechnician().then((value) {
      setState(() {
        technician = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<NavigationDestination> navigation;
    List<Widget> pages;
    if (technician) {
      navigation = [
        const NavigationDestination(
          icon: Icon(Icons.person),
          label: "Transects",
        ),
        const NavigationDestination(
          icon: Icon(Icons.people),
          label: "All transects",
        ),
        const NavigationDestination(
          icon: Icon(Icons.download),
          label: "Download",
        ),
      ];

      pages = [
        const UserTransectsView(),
        const AllTransectsView(),
        const DownloadTransectsView(),
      ];
    } else {
      navigation = [
        const NavigationDestination(
          icon: Icon(Icons.person),
          label: "Transects",
        ),
        const NavigationDestination(
          icon: Icon(Icons.download),
          label: "Download",
        ),
      ];

      pages = [
        const UserTransectsView(),
        const DownloadTransectsView(),
      ];
    }
    return customScaffold(
      context: context,
      title: S.current.transect_records,
      body: pages.elementAt(currentPage),
      bottomNavigationBar: NavigationBar(
        backgroundColor: kColorBackground,
        surfaceTintColor: kColorTitle,
        destinations: navigation,
        selectedIndex: currentPage,
        onDestinationSelected: (int value) {
          if (mounted) {
            setState(
              () {
                currentPage = value;
              },
            );
          }
        },
      ),
    );
  }
}
