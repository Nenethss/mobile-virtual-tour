import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapOverlayWidget extends StatelessWidget {
  final String mapOverlayUrl;

  const MapOverlayWidget({required this.mapOverlayUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return mapOverlayUrl.isNotEmpty
        ? OverlayImageLayer(
            overlayImages: [
              OverlayImage(
                bounds: LatLngBounds(
                  const LatLng(14.480770, 121.187900),
                  const LatLng(14.490150, 121.192350),
                ),
                imageProvider: NetworkImage(mapOverlayUrl),
              ),
            ],
          )
        : const SizedBox.shrink(); // Return empty space if no map URL
  }
}
