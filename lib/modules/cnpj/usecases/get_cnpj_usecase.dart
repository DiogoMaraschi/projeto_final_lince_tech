import '../models/cnpj_model.dart';
import '../../../ui/formatters/app_formatters.dart';
import '../repository.dart';

class GetCnpjUsecase {
  final CnpjRepository repository;

  GetCnpjUsecase({required this.repository});

  Future<CnpjModel> call(String cnpj) async {
    final onlyDigitsCnpj = AppFormatters.onlyNumber(cnpj);
    return await repository.getCnpj(onlyDigitsCnpj);
  }
}
