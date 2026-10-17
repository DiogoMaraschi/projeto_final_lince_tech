import 'package:geocoding/geocoding.dart';

import '../repository.dart';

class GetLocationByAddressUsecase {
  final AddressRepository repository;

  GetLocationByAddressUsecase({required this.repository});

  Future<Location?> call(String street, String city, String number)async{
   return await repository.getLocationByAddress(street, city, number);
}
}