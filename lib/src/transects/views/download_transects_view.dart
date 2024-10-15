import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/transects/controllers/file_io_controller.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/utils/Widgets/android-ios/list_tile_widget.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class DownloadTransectsView extends StatefulWidget {
  final Stream<List<TransectModel>> transects;

  const DownloadTransectsView({
    super.key,
    required this.transects,
  });

  @override
  State<DownloadTransectsView> createState() =>
      _DownloadTransectsViewState(transects);
}

class _DownloadTransectsViewState extends State<DownloadTransectsView> {
  final Stream<List<TransectModel>> transects;

  _DownloadTransectsViewState(this.transects);

  @override
  Widget build(BuildContext context) {
    Logger().d("_DownloadTransectsViewState");
    return StreamBuilder(
        stream: transects,
        builder: (BuildContext context,
            AsyncSnapshot<List<TransectModel>> snapshot) {
          Logger().d(transects.toList());

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: kColorTitle,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, List<TransectModel>> map = {};

            map['all'] = [];

            Logger().d(snapshot.data);

            if (snapshot.data != null) {
              for (var element in snapshot.data!) {
                String localityKey = element.localityFirst == ''
                    ? 'unknown'
                    : element.localityFirst;

                if (!map.containsKey(localityKey)) {
                  map[localityKey] = [];
                }

                map[localityKey]!.add(element);
                map['all']!.add(element);
              }
            }

            return ListView.builder(
              itemCount: map.length,
              itemBuilder: (context, index) {
                String key = map.keys.elementAt(index);
                return ListTileWidget(
                  leading: Text(map[key]!.length.toString()),
                  title: Text(key),
                  trailing: const Icon(Icons.download),
                  onTap: () {
                    FileIOController.saveReports2CSV(
                      context: context,
                      reports: map[key]!,
                      locality: key,
                    );
                  },
                );
              },
            );
          }
        });
  }
}
