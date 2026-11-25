import 'package:dartz/dartz.dart';

import '../../../entities/customer/costumer.dart';
import '../customer_failure.dart';
import '../repository.dart';

class GetAllCustomersUsecase {
  final CustomerRepository repository;

  GetAllCustomersUsecase({required this.repository});

  Future<Either<CustomerListFailure, List<Customer>>> call() async {
    return await repository.getAllCustomers();
  }
}
