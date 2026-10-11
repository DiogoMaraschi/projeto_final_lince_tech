import '../repository.dart';

class DeleteCustomerUsecase {
  final CustomerRepository repository;

  DeleteCustomerUsecase({required this.repository});

  Future<int> call (int id) async{
    return await repository.softDelete(id);
  }

}