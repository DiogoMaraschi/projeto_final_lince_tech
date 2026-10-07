import '../../entities/costumer.dart';
import '../../repositories/customer_repository.dart';

class CreateCustomerUsecase {
  final CustomerRepository repository;

  CreateCustomerUsecase({required this.repository});

  Future<int> call (Customer customer) async{
    print('entrou usecase');
    return await repository.insert(customer);
  }
}