import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkerData {
  final double lat;
  final double lng;
  final String title;
  final String description;
  final String image;

  MarkerData({
    required this.lat,
    required this.lng,
    required this.title,
    required this.description,
    required this.image,
  });

  factory MarkerData.fromJson(Map<String, dynamic> json) {
    return MarkerData(
      lat: json['lat'],
      lng: json['lng'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<MarkerData> markers = [];

  @override
  void initState() {
    super.initState();
    fetchMarkers();
  }

  Future<void> fetchMarkers() async {
    final response =
        await http.get(Uri.parse('http://192.168.100.2:3002/backend/pins'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        markers =
            jsonResponse.map((marker) => MarkerData.fromJson(marker)).toList();
      });
    } else {
      throw Exception('Failed to load markers');
    }
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showMarkerDetails(MarkerData marker) {
    const String baseUrl =
        'http://localhost:3002/backend/images/'; // Adjust based on your image path

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor:
              Colors.black.withOpacity(0.75), // Transparent background
          insetPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Container(
            width: MediaQuery.of(context).size.width, // Full screen width
            height: MediaQuery.of(context).size.height, // Full screen height
            padding: const EdgeInsets.all(25.0), // Padding around the content
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content to start
              children: [
                // Row to align IconButton to left and Title to right
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.translate(
                      offset: const Offset(-10, 0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () =>
                            Navigator.of(context).pop(), // Close dialog
                      ),
                    ),
                    Expanded(
                      child: Text(
                        marker.title,
                        style: const TextStyle(
                          fontSize: 25,
                          color:
                              Colors.white, // White text for better readability
                        ),
                        textAlign: TextAlign.right, // Align text to the right
                        overflow: TextOverflow.ellipsis, // Handle long titles
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    // Allow scrolling if content is too long
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          marker.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          textAlign:
                              TextAlign.justify, // Justify text alignment
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle "Enter Virtual Tour" action here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 105, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Rounded button
                      ),
                      backgroundColor: Colors.grey[800], // Dark button color
                    ),
                    child: const Text(
                      'Enter Virtual Tour',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center, // White text
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(14.482797, 121.187643), // Set initial center
          initialZoom: 19.5, // Set initial zoom level
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: markers.map((marker) {
              return Marker(
                point: LatLng(marker.lat, marker.lng),
                width: 60, // Adjust width
                height: 60, // Adjust height
                child: GestureDetector(
                  onTap: () =>
                      _showMarkerDetails(marker), // Show details on tap
                  child: const Icon(Icons.location_on, color: Colors.red),
                ),
              );
            }).toList(),
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => _launchUrl('https://openstreetmap.org/copyright'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
