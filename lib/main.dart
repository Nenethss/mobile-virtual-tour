import 'package:flutter/material.dart';
import 'map.dart'; // Replace with the actual file name where your map code is

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const MapScreen(), // This should match the class name you defined for your map screen
    );
  }
}
