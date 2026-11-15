import '../../../entities/order/order_edit_data.dart';
import '../repository.dart';

class GetOrderForEditingUsecase {
  final OrderRepository repository;

  GetOrderForEditingUsecase({required this.repository});

  Future<OrderEditData?> call(int orderId) async{
    return await repository.getOrderForEditing(orderId);
  }
}
