import '../../../core/utils/digits_only.dart';
import '../models/cnpj_model.dart';
import '../repository.dart';

class GetCnpjUsecase {
  final CnpjRepository repository;

  GetCnpjUsecase({required this.repository});

  Future<CnpjModel> call(String cnpj) async {
    final onlyDigitsCnpj = digitsOnly(cnpj);
    return await repository.getCnpj(onlyDigitsCnpj);
  }
}
