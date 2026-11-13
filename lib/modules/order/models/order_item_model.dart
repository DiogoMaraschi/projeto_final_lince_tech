import '../../../entities/order/order_item.dart';
import '../../product/models/product_model.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel({
    super.id,
    super.order_id,
    required super.product,
    required super.quantity,
    required super.unitPrice,
    super.discountPercent = 0,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] as int?,
      order_id: map['order_id'] as int,
      product: ProductModel(
        id: map['id'] as int?,
        name: map['name'] as String,
        barcode: map['barcode'] as String,
        description: map['description'] as String?,
        brand: map['brand'] as String,
        imagePath: map['image_path'] as String?,
        salePrice: (map['sale_price'] as num).toDouble(),
        deletedAt: map['deleted_at'] as String?,
      ),
      quantity: map['quantity'] as int,
      unitPrice: (map['unit_price'] as num).toDouble(),
      discountPercent: (map['discount_percent'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap(int orderId) {
    return {
      'order_id': orderId,
      'product_id': product.id,
      'quantity': quantity,
      'unit_price': unitPrice,
      'discount_amount': discountAmount,
      'discount_percent': discountPercent,
    };
  }

  factory OrderItemModel.fromEntity(OrderItem orderItem) {
    return OrderItemModel(
      id: orderItem.id,
      order_id: orderItem.order_id,
      product: orderItem.product,
      quantity: orderItem.quantity,
      unitPrice: orderItem.unitPrice,
      discountPercent: orderItem.discountPercent,
    );
  }
}
