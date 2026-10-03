import '../../entities/carrier.dart';
import '../../repositories/carrier_repository.dart';

class GetAllCarriersUsecase {
  final CarrierRepository repository;

  GetAllCarriersUsecase({required this.repository});

  Future<List<Carrier>> call() async {
    return repository.getAllCarriers();
  }
}
