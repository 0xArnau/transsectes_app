import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/tecnics/tecnic_repository.dart';
import 'package:transsectes_app/src/transects/repositories/transects/transect_repository.dart';
import 'package:transsectes_app/src/transects/views/download_transects_view.dart';
import 'package:transsectes_app/src/transects/views/list_transects_view.dart';
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

  String filter = '';

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
        ListTransectsView(
          transects: userTransects,
          filter: filter,
        ),
        ListTransectsView(
          transects: allTransects,
          filter: filter,
        ),
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
        ListTransectsView(
          transects: userTransects,
          filter: filter,
        ),
        ListTransectsView(
          transects: allTransects,
          filter: filter,
        ),
      ];
    }
    return customScaffold(
      actions: currentPage == pages.length - 1
          ? null
          : <Widget>[
              IconButton(
                onPressed: () async {
                  await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: kColorBackground,
                        title: const Text('Buscar'),
                        content: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            focusColor: kColorTitle,
                            hoverColor: kColorTitle,
                            filled: true,
                            hintText: 'Ciutat o Data...',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kColorTitle,
                              ),
                            ),
                          ),
                          cursorColor: kColorTitle,
                          onChanged: (value) {
                            setState(() {
                              filter = value;
                            });
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: kColorTitle,
                            ),
                            child: const Text('Cancelar'),
                            onPressed: () {
                              setState(() {
                                filter = '';
                              });

                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: kColorTitle,
                            ),
                            child: const Text('Acceptar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ],
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
