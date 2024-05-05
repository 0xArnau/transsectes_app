import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';
import 'package:transsectes_app/src/utils/colors.dart';
import 'package:transsectes_app/src/utils/custom_snackbar.dart';

class TransectView extends StatelessWidget {
  final TransectModel transect;

  const TransectView({
    super.key,
    required this.transect,
  });

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: "Transect detail",
      body: Center(
        child: ListView(
          children: [
            _ListTile(
              title: "Date",
              value: transect.createdAt.toDate().toIso8601String(),
            ),
            _ListTile(
              title: "Author",
              value: transect.createdBy,
            ),
            _ListTile(
              title: "Administrative Area",
              value: transect.administrativeAreaFirst,
            ),
            _ListTile(
              title: "Subadministrative Area",
              value: transect.subAdministrativeAreaFirst,
            ),
            _ListTile(
              title: "Locality",
              value: transect.localityFirst,
            ),
            _ListTile(
              title: "Number of people informed",
              value: transect.informedPeople.toString(),
            ),
            _ListTile(
              title: "Has the tractor passed?",
              value: transect.informedPeople.toString(),
            ),
            _ListTile(
              title: "Number of people informed",
              value: transect.tractor.toString(),
            ),
            _ListTile(
              title: "Observations",
              value: transect.observations,
            ),
            _openMap(
              context: context,
              geopoints: transect.coordinates,
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

  Widget _openMap(
      {required BuildContext context, required List<GeoPoint> geopoints}) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: ElevatedButton.icon(
        onPressed: () {
          CustomSnackbar.error(context, "This feature is not working yet");
        },
        icon: const Icon(Icons.map),
        label: const Text(
          "See transect on map",
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: kColorTitle,
          surfaceTintColor: kColorTitle,
        ),
      ),
    );
  }
}
