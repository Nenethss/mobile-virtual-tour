import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:myflutter/components/dialog_form.dart';
import 'package:myflutter/components/map_overlay.dart';
import 'package:myflutter/components/marker.dart';
import 'package:myflutter/model/marker.dart';
import 'package:myflutter/services/map_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String mapOverlayUrl = '';
  List<MarkerModel> markers = [];
  final MapService _mapService = MapService();

  @override
  void initState() {
    super.initState();
    fetchMarkers();
    fetchCurrentMap();
  }

  Future<void> fetchCurrentMap() async {
    try {
      String filename = await _mapService.fetchCurrentMap();
      setState(() {
        mapOverlayUrl =
            'http://192.168.100.2:3002/server/images/maps/$filename';
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching map: $e');
      }
    }
  }

  Future<void> fetchMarkers() async {
    try {
      List<MarkerModel> markerList = await _mapService.fetchMarkers();
      setState(() {
        markers = markerList;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching markers: $e');
      }
    }
  }

  void _showMarkerDetails(MarkerModel marker) {
    const String baseUrl = 'http://192.168.100.2:3002/server/images/360/';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MarkerDetailsDialog(marker: marker, baseUrl: baseUrl);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(14.485300, 121.190000),
          initialZoom: 17,
          minZoom: 17,
          maxZoom: 17,
        ),
        children: [
          MapOverlayWidget(mapOverlayUrl: mapOverlayUrl),
          MarkerLayerWidget(markers: markers, onMarkerTap: _showMarkerDetails),
        ],
      ),
    );
  }
}
