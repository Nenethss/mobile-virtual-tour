import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class PanoramaScreen extends StatelessWidget {
  final String imageUrl;

  const PanoramaScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Virtual Tour',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Custom back button color
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        backgroundColor: const Color.fromARGB(253, 36, 35, 35),
      ),
      body: Center(
        // Optionally set the height
        child: PanoramaViewer(
          sensorControl: SensorControl.orientation,
          child: Image.network(
            imageUrl,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error,
                  color: Colors.red); // Error icon if the image doesn't load
            },
          ),
        ),
      ),
    );
  }
}
