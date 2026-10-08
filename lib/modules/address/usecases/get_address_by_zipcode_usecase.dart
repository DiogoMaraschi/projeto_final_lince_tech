import '../../../entities/address.dart';
import '../repository.dart';

class GetAddressByZipcodeUsecase {
  final AddressRepository repository;

  GetAddressByZipcodeUsecase({required this.repository});

  Future<Address> call(String zipcode) {
    return repository.getByZipcode(zipcode);
  }
}
