import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../entities/route_result.dart';
import 'datasources/routes_datasource.dart';

abstract class RoutesRepository {
  Future<RouteResult> getDrivingRoute(
    double originLatitude,
    double originLongitude,
    double destinationLatitude,
    double destinationLongitude,
  );
}

class RoutesRepositoryImpl implements RoutesRepository {
  final RoutesDatasource routesDatasource;

  RoutesRepositoryImpl({required this.routesDatasource});

  @override
  Future<RouteResult> getDrivingRoute(
    double originLatitude,
    double originLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    try {
      final result = await routesDatasource.getDrivingRoute(
        originLatitude: originLatitude,
        originLongitude: originLongitude,
        destinationLatitude: destinationLatitude,
        destinationLongitude: destinationLongitude,
      );

      final points = PolylinePoints.decodePolyline(
        result.encodedPolyline,
      ).map((point) => GeoPoint(point.latitude, point.longitude)).toList();

      return RouteResult(distanceMeters: result.distanceMeters, points: points);

    } catch (e) {
      debugPrint('Não foi possível retornar dados $e');
      rethrow;
    }
  }
}
