import '../../entities/address.dart';

abstract class AddressRepository {
  Future<Address> getByZipcode(String zipcode);
}
