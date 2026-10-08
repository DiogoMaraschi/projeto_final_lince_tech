import '../../../entities/carrier.dart';
import '../repository.dart';

class UpdateCarrierUsecase {
  final CarrierRepository repository;

  UpdateCarrierUsecase({required this.repository});

  Future<int> call(Carrier carrier) async {
    return repository.update(carrier);
  }
}
