import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class PanoramaScreen extends StatelessWidget {
  final String imageUrl;

  const PanoramaScreen({super.key, required this.imageUrl});

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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: PanoramaViewer(
             latitude: 0,
            longitude: 0,
            zoom: 1.0,
            minLatitude: 0.0,
            maxLatitude: 0.0,
            minLongitude: -180.0,
            maxLongitude: 180.0,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.red);
              },
            ),
          ),
        ),
      ),
    );
  }
}
