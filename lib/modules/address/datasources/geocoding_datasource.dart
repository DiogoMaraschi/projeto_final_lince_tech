import 'package:geocoding/geocoding.dart';

class GeocodingDatasource {
  final Geocoding geocoding;

  GeocodingDatasource({required this.geocoding});

  Future<Location> getLocationByAddress(
    String street,
    String city,
    String number,
  ) async {
    List<Location> locations = await geocoding.locationFromAddress('''
      $street $number, $city
      ''');
    return locations.first;
  }
}
