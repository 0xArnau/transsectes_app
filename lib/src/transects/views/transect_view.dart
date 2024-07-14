import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/geolocation/controller/geolocation_controller.dart';
import 'package:transsectes_app/src/transects/controllers/file_io_controller.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/transects/transect_repository.dart';
import 'package:transsectes_app/src/transects/views/google_maps_view.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class TransectView extends StatefulWidget {
  final TransectModel transect;

  const TransectView({
    super.key,
    required this.transect,
  });

  @override
  State<TransectView> createState() => _TransectViewState();
}

class _TransectViewState extends State<TransectView> {
  @override
  Widget build(BuildContext context) {
    return customScaffold(
      actions: <Widget>[
        IconButton(
          onPressed: () {
            FileIOController.saveReports2CSV(
                context: context,
                reports: [widget.transect],
                locality: widget.transect.localityFirst);
          },
          icon: const Icon(Icons.download),
        ),
        IconButton(
          onPressed: () {
            GeolocationController()
                .getAddress(widget.transect.coordinates)
                .then((listValue) {
              setState(() {
                widget.transect.administrativeAreaFirst = listValue[0];
                widget.transect.subAdministrativeAreaFirst = listValue[1];
                widget.transect.localityFirst = listValue[2];
                widget.transect.administrativeAreaLast = listValue[3];
                widget.transect.subAdministrativeAreaLast = listValue[4];
                widget.transect.localityLast = listValue[5];
              });

              TransectRepository().updateTransect(widget.transect);
            });
          },
          icon: const Icon(Icons.update),
        ),
      ],
      context: context,
      title: S.current.transect_detail,
      body: Center(
        child: ListView(
          children: [
            _ListTile(
              title: S.current.transect_date,
              value: widget.transect.createdAt.toDate().toIso8601String(),
            ),
            _ListTile(
              title: S.current.transect_author,
              value: widget.transect.createdBy,
            ),
            _ListTileGeo(
              title: S.current.transect_administrative_are,
              value1: widget.transect.administrativeAreaFirst,
              value2: widget.transect.administrativeAreaLast,
            ),
            _ListTileGeo(
              title: S.current.transect_subadministrative_are,
              value1: widget.transect.subAdministrativeAreaFirst,
              value2: widget.transect.subAdministrativeAreaLast,
            ),
            _ListTileGeo(
              title: S.current.transect_locality,
              value1: widget.transect.localityFirst,
              value2: widget.transect.localityLast,
            ),
            _ListTile(
              title: S.current.transect_people_informed,
              value: widget.transect.informedPeople.toString(),
            ),
            _ListTile(
              title: S.current.transect_tractor,
              value: widget.transect.tractor.toString(),
            ),
            _ListTile(
              title: S.current.transect_observations,
              value: widget.transect.observations,
            ),
            _openMap(
              context: context,
              transectModel: widget.transect,
            ),
          ],
        ),
      ),
    );
  }

  Widget _ListTile({required String title, required String value}) {
    return ListTile(
      leading: Text(title),
      title: Text(
        value,
        textAlign: TextAlign.end,
      ),
    );
  }

  Widget _ListTileGeo({
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
                      "$value1 (inici)",
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      "$value2 (final)",
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget _openMap(
      {required BuildContext context, required TransectModel transectModel}) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // CustomSnackbar.error(context, "This feature is not working yet");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return GoogleMapsView(transectModel: transectModel);
              },
            ),
          );
        },
        icon: const Icon(Icons.map),
        label: Text(S.current.open_map),
        style: ElevatedButton.styleFrom(
          foregroundColor: kColorTitle,
          surfaceTintColor: kColorTitle,
        ),
      ),
    );
  }
}
