import '../../core/database/database_helper.dart';
import '../../entities/order/order.dart';
import '../../entities/order/order_edit_data.dart';
import '../../entities/order/order_item.dart';
import '../../entities/order/order_summary.dart';
import '../carrier/models/carrier_model.dart';
import '../customer/models/customer_model.dart';
import '../product/models/product_model.dart';
import 'models/order_item_model.dart';
import 'models/order_model.dart';
import 'models/order_summary_model.dart';

abstract class OrderRepository {
  Future<int> insert(Order order);

  Future<List<OrderSummary>> getAllOrderSummaries();

  Future<OrderEditData?> getOrderForEditing(int orderId);

  Future<int> update(Order order);

  Future<int> softDelete(int orderId);
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
      ) + o.freight + o.additional_fee AS total
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
      o.freight,
       o.additional_fee
    ORDER BY o.created_at DESC, o.id DESC
  ''');

    return rows
        .map<OrderSummary>((row) => OrderSummaryModel.fromMap(row))
        .toList();
  }

  @override
  Future<OrderEditData?> getOrderForEditing(int orderId) async {
    final conn = await databaseHelper.database;

    final result = await conn.query(
      tableName,
      where: 'id = ? AND deleted_at IS NULL',
      whereArgs: [orderId],
    );

    if (result.isEmpty) return null;

    final orderMap = result.first;
    final customerId = orderMap['customer_id'] as int;
    final carrierId = orderMap['carrier_id'] as int;

    final customerMaps = await conn.query(
      'customers',
      where: 'id = ?',
      whereArgs: [customerId],
    );

    final carrierMaps = await conn.query(
      'carriers',
      where: 'id = ?',
      whereArgs: [carrierId],
    );

    if (carrierMaps.isEmpty || customerMaps.isEmpty) {
      throw StateError(
        'O pedido referencia um cliente ou transportadora inexistente',
      );
    }

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

    final order = OrderModel.fromMap(orderMap: orderMap, items: items);
    final customer = CustomerModel.fromMap(customerMaps.first);
    final carrier = CarrierModel.fromMap(carrierMaps.first);

    return OrderEditData(order: order, customer: customer, carrier: carrier);
  }

  @override
  Future<int> update(Order order) async {
    final orderId = order.id;

    if (orderId == null) {
      throw ArgumentError('Não é possível atualizar um pedido sem ID.');
    }

    final orderModel = OrderModel.fromEntity(order);

    final conn = await databaseHelper.database;

    return conn.transaction((txn) async {
      final updatedRows = await txn.update(
        'orders',
        orderModel.toMap(),
        where: 'id = ? AND deleted_at IS NULL',
        whereArgs: [orderId],
      );

      if (updatedRows == 0) return 0;

      await txn.delete(
        'order_items',
        where: 'order_id = ?',
        whereArgs: [orderId],
      );

      for (final item in order.items) {
        final itemModel = OrderItemModel.fromEntity(item);

        await txn.insert('order_items', itemModel.toMap(orderId));
      }

      return updatedRows;
    });
  }

  @override
  Future<int> softDelete(int orderId) async {
    final conn = await databaseHelper.database;

    return conn.update(
      'orders',
      {'deleted_at': DateTime.now().toIso8601String()},
      where: 'id = ? AND deleted_at IS NULL',
      whereArgs: [orderId],
    );
  }
}
