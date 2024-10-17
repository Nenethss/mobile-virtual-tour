import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:myflutter/model/marker.dart';

class MapService {
  final String baseUrl = 'http://192.168.100.2:3002/server';

  Future<String> fetchCurrentMap() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/maps'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        if (jsonResponse.isNotEmpty) {
          return jsonResponse[0]['filename'];
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
