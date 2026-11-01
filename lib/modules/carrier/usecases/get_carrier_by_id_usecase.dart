import '../../../entities/carrier.dart';
import '../repository.dart';

class GetCarrierByIdUsecase {
  final CarrierRepository repository;

  GetCarrierByIdUsecase({required this.repository});

  Future<Carrier?> call(int id) async{
    return await repository.getById(id);
  }
}