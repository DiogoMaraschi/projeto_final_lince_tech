import '../../../entities/customer/costumer.dart';
import '../repository.dart';

class CreateCustomerUsecase {
  final CustomerRepository repository;

  CreateCustomerUsecase({required this.repository});

  Future<int> call(Customer customer) async {
    return await repository.insert(customer);
  }
}
