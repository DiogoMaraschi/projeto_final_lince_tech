import '../../entities/carrier.dart';
import '../../repositories/carrier_repository.dart';

class UpdateCarrierUsecase {
  final CarrierRepository repository;

  UpdateCarrierUsecase({required this.repository});

  Future<int> call (Carrier carrier) async {
    return repository.update(carrier);
  }
}