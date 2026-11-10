import '../../../entities/route_result.dart';
import '../repository.dart';

class GetDrivingRouteUsecase {
  final RoutesRepository repository;

  GetDrivingRouteUsecase({required this.repository});

  Future<RouteResult> call({
    required double originLatitude,
    required double originLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
  }) {
    return repository.getDrivingRoute(
      originLatitude,
      originLongitude,
      destinationLatitude,
      destinationLongitude,
    );
  }
}
