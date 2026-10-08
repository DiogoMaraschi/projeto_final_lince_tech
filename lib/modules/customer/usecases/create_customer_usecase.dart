import '../../../entities/customer.dart';
import '../repository.dart';

class CreateCustomerUsecase {
  final CustomerRepository repository;

  CreateCustomerUsecase({required this.repository});

  Future<int> call(Customer customer) async {
    print('entrou usecase');
    return await repository.insert(customer);
  }
}
