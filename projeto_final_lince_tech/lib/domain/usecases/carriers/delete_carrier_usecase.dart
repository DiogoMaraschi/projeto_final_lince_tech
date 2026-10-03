import '../../repositories/carrier_repository.dart';

class DeleteCarrierUsecase {
  final CarrierRepository repository;

  DeleteCarrierUsecase({required this.repository});

  Future<int> call (int id) async{
    return await repository.softDelete(id);
  }
}
