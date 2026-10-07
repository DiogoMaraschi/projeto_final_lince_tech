import '../../entities/costumer.dart';
import '../../repositories/customer_repository.dart';

class GetAllCustomersUsecase {
  final CustomerRepository repository;

  GetAllCustomersUsecase({required this.repository});

  Future<List<Customer>> call () async{
    return await repository.getAllCustomers();
  }
}