import 'package:flutter/material.dart';
import 'package:myflutter/pages/page_chat.dart';
import 'map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo in the center
              Image.asset(
                'assets/logo.jpg', // Replace with your logo path
                width: 200, // Adjust width as needed
                height: 200, // Adjust height as needed
              ),
              const SizedBox(height: 40), // Space between logo and buttons
              // Buttons in a horizontal row, evenly spaced
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavigationButton(
                    context,
                    label: 'Chat Bot',
                    destination: const PageChat(),
                  ),
                  _buildNavigationButton(
                    context,
                    label: 'Map',
                    destination: const MapScreen(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }

  // Reusable button widget
  Widget _buildNavigationButton(BuildContext context,
      {required String label, required Widget destination}) {
    return SizedBox(
      width: 150, // Adjust width as needed
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 0, 141, 197),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
