import '../../core/database/database_helper.dart';
import '../../entities/order/order.dart';
import '../../entities/order/order_item.dart';
import '../../entities/order/order_summary.dart';
import '../product/models/product_model.dart';
import 'models/order_item_model.dart';
import 'models/order_model.dart';
import 'models/order_summary_model.dart';

abstract class OrderRepository {
  Future<int> insert(Order order);
  Future<List<Order>> getAllOrders();
  Future<List<OrderSummary>> getAllOrderSummaries();
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
      final orderId = await txn.insert('orders', orderModel.toMap());

      for (final item in order.items) {
        final itemModel = OrderItemModel.fromEntity(item);

        await txn.insert('order_items', itemModel.toMap(orderId));
      }

      return orderId;
    });
  }

  @override
  Future<List<Order>> getAllOrders() async {
    final conn = await databaseHelper.database;

    final orderMaps = await conn.query(
      'orders',
      where: 'deleted_at IS NULL',
      orderBy: 'created_at DESC, id DESC',
    );

    final orders = <Order>[];

    for (final orderMap in orderMaps) {
      final orderId = orderMap['id'] as int;

      final itemMaps = await conn.rawQuery(
        '''
      SELECT
        oi.id AS item_id,
        oi.order_id AS item_order_id,
        oi.quantity AS item_quantity,
        oi.unit_price AS item_unit_price,
        oi.discount_percent AS item_discount_percent,
        p.id AS product_id,
        p.name AS product_name,
        p.barcode AS product_barcode,
        p.description AS product_description,
        p.brand AS product_brand,
        p.image_path AS product_image_path,
        p.sale_price AS product_sale_price
      FROM order_items oi
      JOIN products p ON p.id = oi.product_id
      WHERE oi.order_id = ?
      ORDER BY oi.id ASC
      ''',
        [orderId],
      );

      final items = itemMaps.map((map) {
        final product = ProductModel(
          id: map['product_id'] as int,
          name: map['product_name'] as String,
          barcode: map['product_barcode'] as String,
          description: map['product_description'] as String?,
          brand: map['product_brand'] as String,
          imagePath: map['product_image_path'] as String?,
          salePrice: (map['product_sale_price'] as num).toDouble(),
        );

        return OrderItemModel(
          id: map['item_id'] as int,
          order_id: map['item_order_id'] as int,
          product: product,
          quantity: map['item_quantity'] as int,
          unitPrice: (map['item_unit_price'] as num).toDouble(),
          discountPercent: (map['item_discount_percent'] as num).toDouble(),
        );
      }).toList();

      orders.add(OrderModel.fromMap(orderMap: orderMap, items: items));
    }

    return orders;
  }

  @override
  Future<List<OrderSummary>> getAllOrderSummaries() async {
    final conn = await databaseHelper.database;

    final rows = await conn.rawQuery('''
    SELECT
      o.id AS order_id,
      c.name AS customer_name,
      o.payment_method,
      o.installments,
      o.created_at,
      COUNT(oi.id) AS products_count,
      COALESCE(
        SUM(oi.unit_price * oi.quantity - oi.discount_amount),
        0
      ) + o.freight AS total
    FROM orders o
    JOIN customers c ON c.id = o.customer_id
    LEFT JOIN order_items oi ON oi.order_id = o.id
    WHERE o.deleted_at IS NULL
    GROUP BY
      o.id,
      c.name,
      o.payment_method,
      o.installments,
      o.created_at,
      o.freight
    ORDER BY o.created_at DESC, o.id DESC
  ''');

    return rows
        .map<OrderSummary>((row) => OrderSummaryModel.fromMap(row))
        .toList();
  }
}
