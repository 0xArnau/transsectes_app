import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

class GoogleMapsView extends StatefulWidget {
  final TransectEntity transectEntity;

  const GoogleMapsView({super.key, required this.transectEntity});

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

    if (mounted) {
      setState(() {
        initialPosition = LatLng(
          widget.transectEntity.coordinates[0].latitude,
          widget.transectEntity.coordinates[0].longitude,
        );

        if (widget.transectEntity.localityFirst ==
            widget.transectEntity.localityLast) {
          title = widget.transectEntity.localityFirst;
        } else {
          title =
              '${widget.transectEntity.localityFirst} - ${widget.transectEntity.localityLast}';
        }

        markers = widget.transectEntity.coordinates
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: 14,
          ),
          markers: markers,
        ),
      ),
    );
  }
}
