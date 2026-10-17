import '../../entities/address.dart';
import 'package:flutter/foundation.dart';
import './datasources/brasil_api_datasource.dart';
import './datasources/viacep_api_datasource.dart';

abstract class AddressRepository {
  Future<Address> getByZipcode(String zipcode);
}

class AddressRepositoryImpl implements AddressRepository {
  final BrasilApiDatasource brasilApiDatasource;
  final ViacepApiDatasource viacepApiDatasource;

  AddressRepositoryImpl({
    required this.brasilApiDatasource,
    required this.viacepApiDatasource,
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
}
