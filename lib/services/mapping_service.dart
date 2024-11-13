import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:myflutter/model/marker.dart';

class MapService {
  final String baseUrl = 'https://guideurself.onrender.com/backend';

  Future<String> fetchCurrentMap() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/maps'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        if (jsonResponse.isNotEmpty) {
          String filename = jsonResponse[0]['filename'];

          // If filename is already a full URL, return it as-is
          if (filename.startsWith('http')) {
            return filename;
          } else {
            // Otherwise, prepend the baseUrl
            return '$baseUrl/maps/$filename';
          }
        }
      }
      throw Exception('Failed to load map image');
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching map image: $e');
      }
      rethrow;
    }
  }

  Future<List<MarkerModel>> fetchMarkers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/pins'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((marker) => MarkerModel.fromJson(marker))
            .toList();
      }
      throw Exception('Failed to load markers');
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching markers: $e');
      }
      rethrow;
    }
  }
}
