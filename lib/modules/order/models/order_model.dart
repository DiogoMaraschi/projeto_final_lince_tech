import '../../../entities/order/order.dart';
import '../../../entities/order/order_item.dart';
import '../../../entities/order/payment_type.dart';

class OrderModel extends Order {
  final String? deletedAt;

  OrderModel({
    super.id,
    required super.customerId,
    required super.carrierId,
    required super.paymentItem,
    required super.freight,
    super.paymentNotes,
    super.generalNotes,
    required super.createdAt,
    required super.items,
    this.deletedAt,
  });

  factory OrderModel.fromMap({
    required Map<String, dynamic> orderMap,
    required List<OrderItem> items,
  }) {
    return OrderModel(
      id: orderMap['id'] as int?,
      customerId: orderMap['customer_id'] as int,
      carrierId: orderMap['carrier_id'] as int,
      paymentItem: PaymenItem(
        paymentType: PaymentType.fromDatabaseValue(
          orderMap['payment_method'] as String,
        ),
        installments: orderMap['installments'] as int,
      ),
      freight: (orderMap['freight'] as num).toDouble(),
      paymentNotes: orderMap['payment_notes'] as String?,
      generalNotes: orderMap['general_notes'] as String?,
      createdAt: DateTime.parse(orderMap['created_at'] as String),
      deletedAt: orderMap['deleted_at'] as String?,
      items: items,
    );
  }

  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      customerId: order.customerId,
      carrierId: order.carrierId,
      paymentItem: order.paymentItem,
      freight: order.freight,
      paymentNotes: order.paymentNotes,
      generalNotes: order.generalNotes,
      createdAt: order.createdAt,
      items: order.items,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'customer_id': customerId,
      'carrier_id': carrierId,
      'payment_item': paymentItem,
      'freight': freight,
      'payment_notes': paymentNotes,
      'general_notes': generalNotes,
      'created_at': createdAt,
    };
  }
}
