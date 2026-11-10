import 'dart:convert';

import 'package:http/http.dart' as http;

import '../routes_result_model.dart';

class RoutesDatasource {
  static const apiKey = String.fromEnvironment('GOOGLE_ROUTES_API_KEY');

  Future<RoutesResultModel> getDrivingRoute({
    required double originLatitude,
    required double originLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
  }) async {
    if (apiKey.isEmpty) {
      throw Exception('GOOGLE_ROUTES_API_KEY não foi definida');
    }

    final response = await http.post(
      Uri.https('routes.googleapis.com', '/directions/v2:computeRoutes'),
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': apiKey,
        'X-Goog-FieldMask':
            'routes.distanceMeters,routes.polyline.encodedPolyline',
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
      throw Exception('Routes HTTP ${response.statusCode}: ${response.body}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = data['routes'] as List<dynamic>?;

    print(response.body);

    if (routes == null || routes.isEmpty) {
      throw Exception('Nenhuma rota encontrada');
    }

    final route = routes.first as Map<String, dynamic>;
    final polylineData = route['polyline'] as Map<String, dynamic>;
    final distance = (route['distanceMeters'] as num).toInt();
    final polyline = polylineData['encodedPolyline'] as String;

    return RoutesResultModel(
      distanceMeters: distance,
      encodedPolyline: polyline,
    );
  }
}
