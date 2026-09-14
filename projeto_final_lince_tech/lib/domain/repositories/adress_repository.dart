import '../../data/datasources/brasil_api_datasource.dart';
import '../../data/datasources/viacep_api_datasource.dart';
import '../../data/models/adress_model.dart';

abstract class AdressRepository {
  Future<AdressModel> getByZipcode(String zipcode);
}

class AdressRepositoryImpl implements AdressRepository {
  final BrasilApiDatasource brasilApiDatasource;
  final ViacepApiDatasource viacepApiDatasource;

  AdressRepositoryImpl({
    required this.brasilApiDatasource,
    required this.viacepApiDatasource,
  });

  @override
  Future<AdressModel> getByZipcode(String zipcode) async {
    try {
      print('brasil api');
      return await brasilApiDatasource.getByZipcode(zipcode);
    } catch (e) {
      print('viacep');
      return await viacepApiDatasource.getByZipcode(zipcode);
    }
  }
}
