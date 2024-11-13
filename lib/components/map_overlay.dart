import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapOverlayWidget extends StatelessWidget {
  final String mapOverlayUrl;

  const MapOverlayWidget({required this.mapOverlayUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Set the background color here
      child: mapOverlayUrl.isNotEmpty
          ? OverlayImageLayer(
              overlayImages: [
                OverlayImage(
                  bounds: LatLngBounds(
                    const LatLng(14.480740, 121.184750),
                    const LatLng(14.488870, 121.192500),
                  ),
                  imageProvider: NetworkImage(mapOverlayUrl),
                ),
              ],
            )
          : const SizedBox.shrink(), // Return empty space if no map URL
    );
  }
}
