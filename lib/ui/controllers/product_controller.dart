import 'package:flutter/material.dart';
import '../../entities/product.dart';
import '../../modules/imagePicker/usecases/capture_image_usecase.dart';
import '../../modules/product/usecases/create_product_usecase.dart';
import '../../modules/product/usecases/delete_product_usecase.dart';
import '../../modules/product/usecases/update_product_usecase.dart';
import '../formatters/app_formatters.dart';

class ProductController with ChangeNotifier {
  Product? _productReceived;
  final CreateProductUsecase _createProductUsecase;
  final CaptureImageUsecase _captureImageUsecase;
  final UpdateProductUsecase _updateProductUsecase;
  final DeleteProductUsecase _deleteProductUsecase;

  ProductController({
    required this._createProductUsecase,
    required this._captureImageUsecase,
    required this._updateProductUsecase,
    required this._deleteProductUsecase,
    Product? product,
  }) : _productReceived = product {
    if (product != null) {
      _fillFields(product);
    }
  }

  final nameController = TextEditingController();
  final barcodeController = TextEditingController();
  final descriptionController = TextEditingController();
  final brandController = TextEditingController();
  final salePriceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    barcodeController.dispose();
    descriptionController.dispose();
    brandController.dispose();
    salePriceController.dispose();

    super.dispose();
  }

  String? _imagePath;

  String? get imagePath => _imagePath;

  bool get isEditing => _productReceived != null;

  Future<void> captureImage() async {
    final path = await _captureImageUsecase();

    if (path != null) {
      _imagePath = path;
      notifyListeners();
    }
  }

  Future<bool> saveProduct() async {
    final productEdited = convertTextToProduct();

    try {
      if (isEditing) {
        await _updateProductUsecase(productEdited);
        print('editado');
      } else {
        await _createProductUsecase(productEdited);
        print('criado');
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Product convertTextToProduct() {
    return Product(
      id: _productReceived?.id,
      name: nameController.text,
      barcode: barcodeController.text,
      description: descriptionController.text,
      brand: brandController.text,
      imagePath: _imagePath,
      salePrice: _parseMoney(salePriceController.text),
    );
  }

  double _parseMoney(String value) {
    final digits = AppFormatters.onlyNumber(value);
    return int.parse(digits) / 100;
  }

  void _fillFields(Product product) {
    nameController.text = product.name;
    barcodeController.text = product.barcode;
    brandController.text = product.brand;
    descriptionController.text = product.description ?? '';
    _imagePath = product.imagePath;
    salePriceController.text = product.salePrice.toString();
  }

  Future<bool> delete() async {
    if (_productReceived?.id == null) {
      return false;
    }

    try {
      await _deleteProductUsecase(_productReceived!.id!);
      return true;
    } catch (e) {
      return false;
    }
  }
}
