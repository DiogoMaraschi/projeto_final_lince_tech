import '../../../entities/costumer.dart';
import '../repository.dart';

class GetCustomerByIdUsecase {
  final CustomerRepository repository;

  GetCustomerByIdUsecase({required this.repository});

  Future<Customer?> call(int id) async {
    return await repository.getById(id);
  }
}
