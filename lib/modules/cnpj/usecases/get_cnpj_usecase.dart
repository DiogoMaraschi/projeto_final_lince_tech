import '../../../data/models/cnpj_model.dart';
import '../repository.dart';

class GetCnpjUsecase {
  final CnpjRepository repository;

  GetCnpjUsecase({required this.repository});

  Future<CnpjModel> call(String cnpj) async {
    return await repository.getCnpj(cnpj);
  }
}
