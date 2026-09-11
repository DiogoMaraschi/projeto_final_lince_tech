import '../../domain/entities/product.dart';

class ProductModel extends Product {
  final String? deletedAt;

  ProductModel({
    super.id,
    required super.name,
    required super.barcode,
    super.description,
    required super.brand,
    super.imagePath,
    this.deletedAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      barcode: map['barcode'] as String,
      description: map['description'] as String?,
      brand: map['brand_id'] as String,
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
      'brand_id': brand,
      'image_path': imagePath,
      'deleted_at': deletedAt,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      barcode: product.barcode,
      description: product.description,
      brand: product.brand,
      imagePath: product.imagePath,
    );
  }
}
