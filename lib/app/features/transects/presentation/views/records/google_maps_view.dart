import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard functionality
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// View for displaying the map with markers based on transect coordinates.
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

        // Set the title depending on locality values
        if (widget.transectEntity.localityFirst ==
            widget.transectEntity.localityLast) {
          title = widget.transectEntity.localityFirst;
        } else {
          title =
              '${widget.transectEntity.localityFirst} - ${widget.transectEntity.localityLast}';
        }

        // Prepare markers for each coordinate in the transect
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
        actions: [
          // IconButton for copying the Google Maps URL
          IconButton(
            onPressed: _copyGoogleMapsUrl,
            icon: const Icon(Icons.copy),
          ),
        ],
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

  /// Generates a Google Maps URL with waypoints from transect coordinates.
  String _generateGoogleMapsUrl() {
    final coordinates = widget.transectEntity.coordinates;
    if (coordinates.isEmpty) return '';

    final origin = coordinates.first;
    final destination = coordinates.last;
    final waypoints = coordinates.skip(1).take(coordinates.length - 2);

    // Generate the waypoints string
    final waypointsString = waypoints
        .map((point) => '${point.latitude},${point.longitude}')
        .join('|');

    // Return the complete Google Maps direction URL
    return 'https://www.google.com/maps/dir/?api=1'
        '&origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&waypoints=$waypointsString';
  }

  /// Copies the generated Google Maps URL to the clipboard.
  void _copyGoogleMapsUrl() {
    final url = _generateGoogleMapsUrl();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: No coordinates available to generate the URL'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Copy the URL to the clipboard
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Google Maps URL copied to clipboard!',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
