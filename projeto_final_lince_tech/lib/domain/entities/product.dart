class Product {
  final int? id;
  final String name;
  final String barcode;
  final String? description;
  final int brandId;
  final String? imagePath;

  Product({
    this.id,
    required this.name,
    required this.barcode,
    this.description,
    required this.brandId,
    this.imagePath,
  });
}
