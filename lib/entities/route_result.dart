class GeoPoint {
  final double latitude;
  final double longitude;

  const GeoPoint(this.latitude, this.longitude);
}

class RouteResult {
  final int distanceMeters;
  final List<GeoPoint> points;

  const RouteResult({
    required this.distanceMeters,
    required this.points,
  });
}