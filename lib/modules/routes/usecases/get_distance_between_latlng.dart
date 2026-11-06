import '../datasources/routes_datasource.dart';
import '../repository.dart';

class GetDistanceBetweenLatlng {
  final RoutesRepository repository;

  GetDistanceBetweenLatlng({required this.repository});

  Future<int> call({
    required double originLatitude,
    required double originLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
  }) {
    return repository.getDrivingDistanceInMeters(
      originLatitude,
      originLongitude,
      destinationLatitude,
      destinationLongitude,
    );
  }
}
