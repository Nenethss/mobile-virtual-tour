import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:myflutter/model/marker.dart';

class MarkerLayerWidget extends StatelessWidget {
  final List<MarkerModel> markers;
  final Function(MarkerModel) onMarkerTap;

  const MarkerLayerWidget({
    required this.markers,
    required this.onMarkerTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: markers.map((marker) {
        return Marker(
          point: LatLng(marker.lat, marker.lng),
          width: 60,
          height: 60,
          child: GestureDetector(
            onTap: () => onMarkerTap(marker),
            child: const Icon(Icons.location_on, color: Colors.red),
          ),
        );
      }).toList(),
    );
  }
}
