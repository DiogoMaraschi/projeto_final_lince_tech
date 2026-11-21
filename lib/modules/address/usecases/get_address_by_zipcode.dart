import '../../../core/utils/digits_only.dart';
import '../../../entities/address.dart';
import '../../../ui/formatters/input_formatters.dart';
import '../repository.dart';

class GetAddressByZipcodeUsecase {
  final AddressRepository repository;

  GetAddressByZipcodeUsecase({required this.repository});

  Future<Address> call(String zipcode) {
    final onlyDigitsZipcode = digitsOnly(zipcode);
    return repository.getByZipcode(onlyDigitsZipcode);
  }
}
