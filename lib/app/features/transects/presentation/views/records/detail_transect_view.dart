import 'package:flutter/material.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/records/google_maps_view.dart';
import 'package:transsectes_app/generated/l10n.dart';

class DetailTransectView extends StatefulWidget {
  final TransectEntity transect;

  const DetailTransectView({
    super.key,
    required this.transect,
  });

  @override
  State<DetailTransectView> createState() => _DetailTransectViewState();
}

class _DetailTransectViewState extends State<DetailTransectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // FileIOController.saveReports2CSV(
              //     context: context,
              //     reports: [widget.transect],
              //     locality: widget.transect.localityFirst);
            },
            icon: const Icon(Icons.download),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.update),
          ),
        ],
        title: Text(S.current.transect_detail),
      ),
      body: Center(
        child: ListView(
          children: [
            _listTile(
              title: S.current.transect_date,
              value: widget.transect.createdAt.toDate().toIso8601String(),
            ),
            _listTile(
              title: S.current.transect_author,
              value: widget.transect.createdBy,
            ),
            _listTileGeo(
              title: S.current.transect_administrative_are,
              value1: widget.transect.administrativeAreaFirst,
              value2: widget.transect.administrativeAreaLast,
            ),
            _listTileGeo(
              title: S.current.transect_subadministrative_are,
              value1: widget.transect.subAdministrativeAreaFirst,
              value2: widget.transect.subAdministrativeAreaLast,
            ),
            _listTileGeo(
              title: S.current.transect_locality,
              value1: widget.transect.localityFirst,
              value2: widget.transect.localityLast,
            ),
            _listTile(
              title: S.current.transect_people_informed,
              value: widget.transect.informedPeople.toString(),
            ),
            _listTile(
              title: S.current.transect_tractor,
              value: widget.transect.tractor.toString(),
            ),
            _listTile(
              title: S.current.transect_observations,
              value: widget.transect.observations,
            ),
            _openMap(
              context: context,
              transectEntity: widget.transect,
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile({required String title, required String value}) {
    return ListTile(
      leading: Text(title),
      title: Text(
        value,
        textAlign: TextAlign.end,
      ),
    );
  }

  Widget _listTileGeo({
    required String title,
    required String value1,
    required String value2,
  }) {
    return ListTile(
      leading: Text(title),
      title: value1 == value2
          ? Text(
              value1,
              textAlign: TextAlign.right,
            )
          : SizedBox(
              height: 48,
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$value1 (inici)',
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      '$value2 (final)',
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget _openMap(
      {required BuildContext context, required TransectEntity transectEntity}) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // CustomSnackbar.error(context, "This feature is not working yet");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return GoogleMapsView(transectEntity: transectEntity);
              },
            ),
          );
        },
        icon: const Icon(Icons.map),
        label: Text(S.current.open_map),
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
