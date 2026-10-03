import '../../entities/address.dart';
import '../../repositories/address_repository.dart';

class GetAddressByZipcodeUsecase {
  final AddressRepository repository;

  GetAddressByZipcodeUsecase({required this.repository});

  Future<Address> call(String zipcode) async {
    return await repository.getByZipcode(zipcode);
  }
}
