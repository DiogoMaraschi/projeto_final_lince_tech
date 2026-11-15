import 'payment_type.dart';

class OrderSummary {
  int id;
  String customerName;
  String created_at;
  int productsCount;
  PaymentItem paymentItem;
  double total;

  OrderSummary({
    required this.id,
    required this.customerName,
    required this.created_at,
    required this.paymentItem,
    required this.productsCount,
    required this.total,
  });
}
