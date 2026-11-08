import '../product.dart';

class OrderItemDraft {
  final Product product;
  final int quantity;
  final double unitPrice;
  final double discountPercent;

  const OrderItemDraft({
    required this.product,
    required this.quantity,
    required this.unitPrice,
    this.discountPercent = 0,
  });

  double get discountAmount =>
      subtotal * discountPercent.clamp(0, 100) / 100;

  double get subtotal => unitPrice * quantity;
  double get total => subtotal - discountAmount;

  OrderItemDraft copyWith({
    int? quantity,
    double? discountPercent,
  }) {
    return OrderItemDraft(
      product: product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice,
      discountPercent: discountPercent ?? this.discountPercent,
    );
  }
}
