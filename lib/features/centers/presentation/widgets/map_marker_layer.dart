import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class MapMarkerLayer extends StatelessWidget {
  final LatLng markerPosition;
  const MapMarkerLayer(this.markerPosition, {super.key});

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          width: 40,
          height: 40,
          child: const Icon(Icons.location_on, size: 40, color: Colors.red),
          point: markerPosition,
        ),
      ],
    );
  }
}
