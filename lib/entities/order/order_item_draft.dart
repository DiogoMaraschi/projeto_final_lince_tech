import '../product.dart';

class OrderItemDraft {
  final Product product;
  final int quantity;
  final double unitPrice;
  final double discountAmount;
  final double discountPercent;

  const OrderItemDraft({
    required this.product,
    required this.quantity,
    required this.unitPrice,
    this.discountPercent = 0,
    this.discountAmount = 0,
  });

  double get subtotal => unitPrice * quantity;
  double get total => subtotal - discountAmount;

  OrderItemDraft copyWith({
    int? quantity,
    double? discountAmount,
    double? discountPercent,
  }) {
    return OrderItemDraft(
      product: product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercent: discountPercent ?? this.discountPercent,
    );
  }
}
