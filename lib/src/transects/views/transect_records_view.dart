import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/tecnics/tecnic_repository.dart';
import 'package:transsectes_app/src/transects/repositories/transects/transect_repository.dart';
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
  Stream<List<TransectModel>> allTransects = const Stream.empty();
  Stream<List<TransectModel>> userTransects = const Stream.empty();

  bool technician = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    TecnicRepository().isTechnician().then((value) {
      setState(() {
        technician = value;
      });

      if (value) {
        Stream<List<TransectModel>> stream =
            TransectRepository().getAllTransects();

        Stream<List<TransectModel>> orderedStream = stream.map((list) {
          return list..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        });

        setState(() {
          allTransects = orderedStream;
        });
      }
    });

    Stream<List<TransectModel>> stream =
        TransectRepository().getUserTransects("0xarnau@gmail.com");

    Stream<List<TransectModel>> orderedStream = stream.map((list) {
      return list..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });

    setState(() {
      userTransects = orderedStream;
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
        UserTransectsView(transects: userTransects),
        AllTransectsView(transects: allTransects),
        DownloadTransectsView(transects: allTransects),
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
        UserTransectsView(transects: userTransects),
        DownloadTransectsView(transects: allTransects),
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
