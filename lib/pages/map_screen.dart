import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:myflutter/components/dialog_form.dart';
import 'package:myflutter/components/map_overlay.dart';
import 'package:myflutter/components/marker.dart';
import 'package:myflutter/model/marker.dart';
import 'package:myflutter/services/mapping_service.dart';
import 'package:myflutter/components/map_drawer.dart'; // Import MapDrawer

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
        mapOverlayUrl = filename;
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MarkerDetailsDialog(marker: marker);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      endDrawer: MapDrawer(
        markers: markers,
        onMarkerTap: _showMarkerDetails,
      ), // Pass markers to MapDrawer
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(14.484750, 121.189000),
          initialZoom: 17,
          minZoom: 16,
          maxZoom: 19,
          interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag),
        ),
        children: [
          MapOverlayWidget(mapOverlayUrl: mapOverlayUrl),
          MarkerLayerWidget(markers: markers, onMarkerTap: _showMarkerDetails),
        ],
      ),
    );
  }
}
