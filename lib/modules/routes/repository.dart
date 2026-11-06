import 'package:flutter/cupertino.dart';

import 'datasources/routes_datasource.dart';

abstract class RoutesRepository {
  Future<int> getDrivingDistanceInMeters(
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
  Future<int> getDrivingDistanceInMeters(
    double originLatitude,
    double originLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    try {
      print('''
      origin lat $originLatitude,
      origin long $originLongitude,
      dest lat $destinationLatitude,
      dest long $destinationLongitude
      ''');
      return await routesDatasource.getDrivingDistanceInMeters(
        originLatitude: originLatitude,
        originLongitude: originLongitude,
        destinationLatitude: destinationLatitude,
        destinationLongitude: destinationLongitude,
      );
    } catch (e) {
      debugPrint('Não foi possível retornar dados $e');
      return -1;
    }
  }
}
