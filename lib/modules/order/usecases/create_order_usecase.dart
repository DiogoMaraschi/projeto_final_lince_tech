import '../../../entities/order/order.dart';
import '../repository.dart';

class CreateOrderUsecase {
  final OrderRepository repository;

  CreateOrderUsecase({required this.repository});

  Future<int> call(Order order) async {
    return await repository.insert(order);
  }
}
