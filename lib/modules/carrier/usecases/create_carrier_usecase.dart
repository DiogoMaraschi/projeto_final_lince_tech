import '../../../entities/carrier.dart';
import '../repository.dart';

class CreateCarrierUsecase {
  final CarrierRepository repository;

  CreateCarrierUsecase({required this.repository});

  Future<int> call(Carrier carrier) async {
    return repository.insert(carrier);
  }
}
