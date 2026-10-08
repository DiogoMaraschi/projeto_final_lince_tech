import '../../../entities/carrier.dart';
import '../repository.dart';

class GetAllCarriersUsecase {
  final CarrierRepository repository;

  GetAllCarriersUsecase({required this.repository});

  Future<List<Carrier>> call() async {
    return repository.getAllCarriers();
  }
}
