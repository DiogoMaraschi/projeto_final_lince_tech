import '../../../entities/customer.dart';
import '../repository.dart';

class GetAllCustomersUsecase {
  final CustomerRepository repository;

  GetAllCustomersUsecase({required this.repository});

  Future<List<Customer>> call() async {
    return await repository.getAllCustomers();
  }
}
