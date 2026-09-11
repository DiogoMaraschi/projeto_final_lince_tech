import '../../../data/models/cnpj_model.dart';
import '../../repositories/cnpj_repository.dart';

class GetCnpjUsecase {
  final CnpjRepository repository;

  GetCnpjUsecase({required this.repository});

  Future<CnpjModel> call(String cnpj) async {
    return await repository.getCnpj(cnpj);
  }
}
