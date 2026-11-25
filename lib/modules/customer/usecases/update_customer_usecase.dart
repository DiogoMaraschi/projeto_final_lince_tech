import 'package:dartz/dartz.dart';

import '../../../entities/customer/costumer.dart';
import '../customer_failure.dart';
import '../repository.dart';

class UpdateCustomerUsecase {
  final CustomerRepository repository;

  UpdateCustomerUsecase({required this.repository});

  Future<Either<CustomerFailure, int>> call (Customer customer) async{
    return await repository.update(customer);
  }

}