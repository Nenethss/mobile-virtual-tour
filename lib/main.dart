import 'package:flutter/material.dart';
import 'package:myflutter/pages/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.grey.shade100,
        child: const SafeArea(child: MapScreen()),
      ),
    );
  }
}
