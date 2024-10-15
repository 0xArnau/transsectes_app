import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/geolocation/controller/geolocation_controller.dart';
import 'package:transsectes_app/src/transects/controllers/file_io_controller.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/transects/transect_repository.dart';
import 'package:transsectes_app/src/transects/views/google_maps_view.dart';
import 'package:transsectes_app/src/utils/Widgets/android-ios/list_tile_chevron_widget.dart';
import 'package:transsectes_app/src/utils/Widgets/android-ios/list_tile_widget.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';

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
              if (mounted) {
                setState(() {
                  widget.transect.administrativeAreaFirst = listValue[0];
                  widget.transect.subAdministrativeAreaFirst = listValue[1];
                  widget.transect.localityFirst = listValue[2];
                  widget.transect.administrativeAreaLast = listValue[3];
                  widget.transect.subAdministrativeAreaLast = listValue[4];
                  widget.transect.localityLast = listValue[5];
                });
              }

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
            _buildListTile(
              title: S.current.transect_date,
              value: widget.transect.createdAt.toDate().toIso8601String(),
            ),
            _buildListTile(
              title: S.current.transect_author,
              value: widget.transect.createdBy,
            ),
            _buildListTileGeo(
              title: S.current.transect_administrative_are,
              value1: widget.transect.administrativeAreaFirst,
              value2: widget.transect.administrativeAreaLast,
            ),
            _buildListTileGeo(
              title: S.current.transect_subadministrative_are,
              value1: widget.transect.subAdministrativeAreaFirst,
              value2: widget.transect.subAdministrativeAreaLast,
            ),
            _buildListTileGeo(
              title: S.current.transect_locality,
              value1: widget.transect.localityFirst,
              value2: widget.transect.localityLast,
            ),
            _buildListTile(
              title: S.current.transect_people_informed,
              value: widget.transect.informedPeople.toString(),
            ),
            _buildListTile(
              title: S.current.transect_tractor,
              value: widget.transect.tractor.toString(),
            ),
            _buildListTile(
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

  Widget _buildListTile({required String title, required String value}) {
    return ListTileWidget(
      title: Text(title),
      subtitle: Text(value),
    );
  }

  Widget _buildListTileGeo({
    required String title,
    required String value1,
    required String value2,
  }) {
    return ListTileWidget(
      title: Text(title),
      subtitle: value1 == value2
          ? Text(value1, textAlign: TextAlign.left)
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("$value1 (inici)", textAlign: TextAlign.left),
                const Text("-"),
                Text("$value2 (final)", textAlign: TextAlign.left),
              ],
            ),
    );
  }

  Widget _openMap({
    required BuildContext context,
    required TransectModel transectModel,
  }) {
    return ListTileChevronWidget(
      // leading: const Icon(Icons.map),
      title: Text(S.current.open_map),
      goto: () => GoogleMapsView(transectModel: transectModel),
    );
  }
}
