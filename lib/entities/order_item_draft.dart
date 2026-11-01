import 'product.dart';

class OrderItemDraft {
  final Product product;
  final int quantity;
  final double unitPrice;

  const OrderItemDraft({
    required this.product,
    required this.quantity,
    required this.unitPrice,
  });

  double get subtotal => unitPrice * quantity;

  OrderItemDraft copyWith({
    int? quantity,
  }) {
    return OrderItemDraft(
      product: product,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice,
    );
  }
}