import '../../data/models/cnpj_model.dart';

abstract class CnpjRepository {
  Future<CnpjModel> getCnpj(String cnpj);
}
