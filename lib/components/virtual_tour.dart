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
        color: Colors.black, // Set the background color for the entire screen
        child: Center(
          child: PanoramaViewer(
            child: Image.network(
              imageUrl,
              fit:
                  BoxFit.cover, // Ensures the image scales to fit the container
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error,
                    color: Colors.red); // Error icon if the image fails to load
              },
            ),
          ),
        ),
      ),
    );
  }
}