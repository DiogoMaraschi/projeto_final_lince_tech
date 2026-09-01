import '../../domain/entities/product.dart';

class ProductModel extends Product {
  final String? deletedAt;

  ProductModel({
    super.id,
    required super.name,
    required super.barcode,
    super.description,
    required super.brandId,
    super.imagePath,
    this.deletedAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      barcode: map['barcode'] as String,
      description: map['description'] as String?,
      brandId: map['brand_id'] as int,
      imagePath: map['image_path'] as String?,
      deletedAt: map['deleted_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'barcode': barcode,
      'description': description,
      'brand_id': brandId,
      'image_path': imagePath,
      'deleted_at': deletedAt,
    };
  }
}
