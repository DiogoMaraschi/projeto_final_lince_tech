import '../../modules/cnpj/repository.dart';
import '../datasources/cnpj_api_datasource.dart';
import '../models/cnpj_model.dart';

class CnpjRepositoryImpl implements CnpjRepository {
  final CnpjApiDatasource dataSource;

  CnpjRepositoryImpl({required this.dataSource});

  Future<CnpjModel> getCnpj(String cnpj) => dataSource.getCnpj(cnpj);
}
