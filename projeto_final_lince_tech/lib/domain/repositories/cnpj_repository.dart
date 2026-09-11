import '../../data/datasources/cnpj_api_datasource.dart';
import '../../data/models/cnpj_model.dart';

abstract class CnpjRepository {
  Future<CnpjModel> getCnpj(String cnpj);
}

class CnpjRepositoryImpl implements CnpjRepository {
  final CnpjApiDatasource dataSource;

  CnpjRepositoryImpl({required this.dataSource});

  @override
  Future<CnpjModel> getCnpj(String cnpj) async {
    return await dataSource.getCnpj(cnpj);
  }
}
