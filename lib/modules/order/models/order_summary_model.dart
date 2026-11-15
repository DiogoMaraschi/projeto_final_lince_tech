import '../../../entities/order/order_summary.dart';
import '../../../entities/order/payment_type.dart';

class OrderSummaryModel extends OrderSummary {
  OrderSummaryModel({
    required super.id,
    required super.customerName,
    required super.paymentItem,
    required super.created_at,
    required super.productsCount,
    required super.total,
  });

  factory OrderSummaryModel.fromMap(Map<String, dynamic> map) {
    return OrderSummaryModel(id: map['order_id'] as int,
        customerName: map['customer_name'] as String,
        paymentItem: PaymentItem(paymentType: PaymentType.fromDatabaseValue(
            map['payment_method'] as String),
            installments: map['installments'] as int),
        created_at: map['created_at'] as String,
        productsCount: map['products_count'] as int,
        total: (map['total'] as num).toDouble());
  }
}
