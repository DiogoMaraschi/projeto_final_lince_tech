import '../product.dart';

class OrderItem {
  final int? id;
  final int? order_id;
  final Product product;
  final int quantity;
  final double unitPrice;
  final double discountPercent;

  const OrderItem({
    this.id,
    this.order_id,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    this.discountPercent = 0,
  });

  double get discountAmount =>
      subtotal * discountPercent.clamp(0, 100) / 100;

  double get subtotal => unitPrice * quantity;
  double get total => subtotal - discountAmount;

  OrderItem copyWith({
    int? id,
    int? quantity,
    double? discountPercent,
  }) {
    return OrderItem(
      id: id ?? this.id,
      product: product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice,
      discountPercent: discountPercent ?? this.discountPercent,
    );
  }
}
