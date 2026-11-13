import 'order_item.dart';
import 'payment_type.dart';

class Order {
  final int? id;
  final int customerId;
  final int carrierId;
  final PaymenItem paymentItem;
  final double freight;
  final String? paymentNotes;
  final String? generalNotes;
  final DateTime createdAt;
  final List<OrderItem> items;

  Order({
    this.id,
    required this.customerId,
    required this.carrierId,
    required this.paymentItem,
    required this.freight,
    this.paymentNotes,
    this.generalNotes,
    required this.createdAt,
    required this.items,
  });
}
