import '../../../entities/order/order_summary.dart';
import '../repository.dart';

class GetAllOrderSummariesUsecase {
  final OrderRepository repository;

  GetAllOrderSummariesUsecase({required this.repository});

  Future<List<OrderSummary>> call() async {
    return await repository.getAllOrderSummaries();
  }
}
