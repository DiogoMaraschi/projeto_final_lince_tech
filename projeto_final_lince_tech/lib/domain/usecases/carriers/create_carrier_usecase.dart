import '../../entities/carrier.dart';
import '../../repositories/carrier_repository.dart';

class CreateCarrierUsecase {
  late final CarrierRepository repository;

  CreateCarrierUsecase({required this.repository});

  Future<int> call(Carrier carrier) async {
    return repository.insert(carrier);
  }
}
