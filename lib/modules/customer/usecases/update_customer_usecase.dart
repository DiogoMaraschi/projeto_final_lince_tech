import '../../../entities/costumer.dart';
import '../repository.dart';

class UpdateCustomerUsecase {
  final CustomerRepository repository;

  UpdateCustomerUsecase({required this.repository});

  Future<int> call (Customer customer) async{
    return await repository.update(customer);
  }

}