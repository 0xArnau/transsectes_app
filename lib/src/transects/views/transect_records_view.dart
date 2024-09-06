import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/tecnics/tecnic_repository.dart';
import 'package:transsectes_app/src/transects/repositories/transects/transect_repository.dart';
import 'package:transsectes_app/src/transects/views/download_transects_view.dart';
import 'package:transsectes_app/src/transects/views/list_transects_view.dart';
import 'package:transsectes_app/src/transects/views/remove_transects_view.dart';
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
  Stream<List<TransectModel>> downloadTransects = const Stream.empty();
  Stream<List<TransectModel>> userTransects = const Stream.empty();
  TextEditingController filter = TextEditingController(text: '');

  String? userEmail;

  bool technician = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    TecnicRepository().isTechnician().then((value) {
      if (mounted) {
        setState(() {
          technician = value;
        });
      }

      if (value) {
        Stream<List<TransectModel>> stream =
            TransectRepository().getAllTransects();

        Stream<List<TransectModel>> orderedStream = stream.map((list) {
          return list..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        });

        if (mounted) {
          setState(() {
            allTransects = orderedStream;
          });
        }
      }
    });

    AuthRepository().getUserEmail().then((value) {
      if (mounted) {
        setState(() {
          userEmail = value;
        });
      }

      Stream<List<TransectModel>> stream =
          TransectRepository().getUserTransects(value);

      Stream<List<TransectModel>> orderedStream = stream.map((list) {
        return list..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      });

      if (mounted) {
        setState(() {
          userTransects = orderedStream;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<NavigationDestination> navigation;
    List<Widget> pages;
    if (technician) {
      navigation = [
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
        )
      ];

      pages = [
        ListTransectsView(
          transects: userTransects,
          filter: filter.text,
        ),
        ListTransectsView(
          transects: allTransects,
          filter: filter.text,
        ),
        DownloadTransectsView(
            transects: TransectRepository().getAllTransects().map((list) {
          return list..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        })),
        const RemoveTransectsView(),
      ];
    } else {
      navigation = [
        NavigationDestination(
          icon: Icon(currentPage == 0 ? Icons.person : Icons.person_outline),
          label: S.current.transects,
        ),
        NavigationDestination(
          icon:
              Icon(currentPage == 1 ? Icons.download : Icons.download_outlined),
          label: S.current.download,
        ),
      ];

      pages = [
        ListTransectsView(
          transects: userTransects,
          filter: filter.text,
        ),
        DownloadTransectsView(
            transects:
                TransectRepository().getUserTransects(userEmail).map((list) {
          return list..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        })),
      ];
    }
    return customScaffold(
      actions: currentPage == pages.length - 1
          ? null
          : <Widget>[
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    onPressed: () {
                      showBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 25,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: filter,
                                  style: const TextStyle(
                                      fontSize:
                                          16.0), // Ajusta el tamaño de fuente del texto
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 12.0,
                                        horizontal:
                                            16.0), // Ajusta el padding interno del TextField
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Ajusta el radio de los bordes
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: S.current.filter_hint,
                                    hintStyle: const TextStyle(
                                        fontSize:
                                            16.0), // Ajusta el tamaño de fuente del texto de hint
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: kColorTitle),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  cursorColor: kColorTitle,
                                  onChanged: (value) {
                                    if (mounted) {
                                      setState(() {
                                        filter.text = value;
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: kColorTitle,
                                      ),
                                      child: Text(S.current.filter_clear),
                                      onPressed: () {
                                        if (mounted) {
                                          setState(() {
                                            filter.clear();
                                            filter.text = '';
                                          });
                                        }
                                      },
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: kColorTitle,
                                      ),
                                      child: Text(S.current.accept),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.search),
                  );
                },
              ),
            ],
      context: context,
      title: S.current.transect_records,
      resizeToAvoidBottomInset: true,
      body: pages.elementAt(currentPage),
      bottomNavigationBar: BottomNavigationBar(
        items: navigation.map((destination) {
          return BottomNavigationBarItem(
            icon: destination.icon,
            label: destination.label,
          );
        }).toList(),
        currentIndex: currentPage,
        selectedItemColor: kColorTitle,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (int index) {
          if (mounted) {
            setState(() {
              currentPage = index;
            });
          }
        },
        // elevation: 0,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
