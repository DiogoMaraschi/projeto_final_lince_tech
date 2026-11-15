import '../../../entities/order/order.dart';
import '../repository.dart';

class GetAllOrdersUsecase {
  final OrderRepository repository;

  GetAllOrdersUsecase({required this.repository});

  Future<List<Order>> call() async {
    return await repository.getAllOrders();
  }
}
