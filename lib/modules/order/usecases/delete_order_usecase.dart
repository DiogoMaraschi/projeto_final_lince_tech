import '../repository.dart';

class DeleteOrderUsecase {
  final OrderRepository repository;

  DeleteOrderUsecase({required this.repository});

  Future<int> call(int orderId) async{
    return await repository.softDelete(orderId);
  }
}