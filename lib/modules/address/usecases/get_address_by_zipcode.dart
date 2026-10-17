import '../../../entities/address.dart';
import '../../../ui/formatters/app_formatters.dart';
import '../repository.dart';

class GetAddressByZipcodeUsecase {
  final AddressRepository repository;

  GetAddressByZipcodeUsecase({required this.repository});

  Future<Address> call(String zipcode) {
    final onlyDigitsZipcode = AppFormatters.onlyNumber(zipcode);
    return repository.getByZipcode(onlyDigitsZipcode);
  }
}
