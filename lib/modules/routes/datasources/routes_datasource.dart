import 'dart:convert';

import 'package:http/http.dart' as http;

class RoutesDatasource {

  static const apiKey = String.fromEnvironment('GOOGLE_ROUTES_API_KEY');

  Future<int> getDrivingDistanceInMeters({
    required double originLatitude,
    required double originLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
  }) async {
    final response = await http.post(
      Uri.https('routes.googleapis.com', '/directions/v2:computeRoutes'),
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': apiKey,
        'X-Goog-FieldMask': 'routes.distanceMeters',
      },
      body: jsonEncode({
        'origin': {
          'location': {
            'latLng': {
              'latitude': originLatitude,
              'longitude': originLongitude,
            },
          },
        },
        'destination': {
          'location': {
            'latLng': {
              'latitude': destinationLatitude,
              'longitude': destinationLongitude,
            },
          },
        },
        'travelMode': 'DRIVE',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Routes HTTP ${response.statusCode}: ${response.body}',
      );
    }

    if (apiKey.isEmpty) {
      throw Exception('GOOGLE_ROUTES_API_KEY não foi definida');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = data['routes'] as List<dynamic>?;

    if (routes == null || routes.isEmpty) {
      throw Exception('Nenhuma rota encontrada');
    }

    return (routes.first['distanceMeters'] as num).toInt();
  }
}