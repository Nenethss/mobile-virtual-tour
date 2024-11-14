// map_drawer.dart

import 'package:flutter/material.dart';
import 'package:myflutter/model/marker.dart';

class MapDrawer extends StatelessWidget {
  final List<MarkerModel> markers;
  final void Function(MarkerModel) onMarkerTap;

  const MapDrawer({
    super.key,
    required this.markers,
    required this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 80,
            color: const Color.fromARGB(255, 0, 141, 197),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Locations',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          ...markers.map((marker) {
            return ListTile(
              title: Text(marker.title),
              onTap: () {
                Navigator.of(context).pop();
                onMarkerTap(marker);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
