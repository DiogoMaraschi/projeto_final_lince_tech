import 'package:geocoding/geocoding.dart';

import '../../entities/address.dart';
import 'package:flutter/foundation.dart';
import './datasources/brasil_api_datasource.dart';
import './datasources/viacep_api_datasource.dart';
import 'datasources/geocoding_datasource.dart';

abstract class AddressRepository {
  Future<Address> getByZipcode(String zipcode);
  Future<Location?> getLocationByAddress(
    String street,
    String city,
    String number,
  );
}

class AddressRepositoryImpl implements AddressRepository {
  final BrasilApiDatasource brasilApiDatasource;
  final ViacepApiDatasource viacepApiDatasource;
  final GeocodingDatasource geocodingDatasource;

  AddressRepositoryImpl({
    required this.brasilApiDatasource,
    required this.viacepApiDatasource,
    required this.geocodingDatasource
  });

  @override
  Future<Address> getByZipcode(String zipcode) async {
    try {
      return await brasilApiDatasource.getByZipcode(zipcode);
    } catch (error) {
      debugPrint('Brasil API failed: $error');
      return viacepApiDatasource.getByZipcode(zipcode);
    }
  }

  @override
  Future<Location?> getLocationByAddress(String street, String city, String number) async{
    try {
      return await geocodingDatasource.getLocationByAddress(street, city, number);
    } catch (error){
      print(error.toString());
    }
  }
}
