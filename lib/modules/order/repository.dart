import '../../core/database/database_helper.dart';
import '../../entities/order/order.dart';
import '../../entities/order/order_item.dart';
import 'models/order_item_model.dart';
import 'models/order_model.dart';

abstract class OrderRepository {
  Future<int> insert(Order order);
}

class OrderRepositoryImpl implements OrderRepository {
  final DatabaseHelper databaseHelper;

  OrderRepositoryImpl({required this.databaseHelper});

  static const String tableName = 'orders';

  @override
  Future<int> insert(Order order) async {
    final orderModel = OrderModel.fromEntity(order);

    final conn = await databaseHelper.database;

    return conn.transaction((txn) async {
      final orderId = await txn.insert(
        'orders',
        orderModel.toMap(),
      );

      for (final item in order.items) {
        final itemModel = OrderItemModel.fromEntity(item);

        await txn.insert(
          'order_items',
          itemModel.toMap(orderId),
        );
      }

      return orderId;
    });
  }
}
