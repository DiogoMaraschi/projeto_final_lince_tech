import '../../../entities/order/order.dart';
import '../repository.dart';

class UpdateOrderUsecase {
  final OrderRepository repository;

  UpdateOrderUsecase({required this.repository});

  Future<int> call(Order order) async{
    return repository.update(order);
  }
}