import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';

class GoogleMapsView extends StatefulWidget {
  final TransectModel transectModel;

  const GoogleMapsView({super.key, required this.transectModel});

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  late LatLng initialPosition;
  String title = '';
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    setState(() {
      initialPosition = LatLng(
        widget.transectModel.coordinates[0].latitude,
        widget.transectModel.coordinates[0].longitude,
      );

      if (widget.transectModel.localityFirst ==
          widget.transectModel.localityLast) {
        title = widget.transectModel.localityFirst;
      } else {
        title =
            "${widget.transectModel.localityFirst} - ${widget.transectModel.localityLast}";
      }

      markers = widget.transectModel.coordinates
          .asMap()
          .map((index, geoPoint) => MapEntry(
                index,
                Marker(
                  markerId: MarkerId(index.toString()),
                  position: LatLng(geoPoint.latitude, geoPoint.longitude),
                  infoWindow: InfoWindow(
                    title: 'Marker $index',
                    snippet:
                        'Lat: ${geoPoint.latitude}, Lng: ${geoPoint.longitude}',
                  ),
                ),
              ))
          .values
          .toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: title,
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 14,
        ),
        markers: markers,
      ),
    );
  }
}
