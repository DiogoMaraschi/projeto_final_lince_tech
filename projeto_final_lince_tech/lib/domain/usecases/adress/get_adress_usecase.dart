import '../../../data/models/adress_model.dart';
import '../../repositories/adress_repository.dart';

class GetAdressUsecase {
  final AdressRepositoryImpl repository;

  GetAdressUsecase({required this.repository});

  Future<AdressModel> call(String zipcode) async {
    return await repository.getByZipcode(zipcode);
  }
}
