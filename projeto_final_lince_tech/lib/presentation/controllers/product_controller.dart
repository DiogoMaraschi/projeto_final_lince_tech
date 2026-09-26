import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/capture_image_usecase.dart';
import '../../domain/usecases/products/create_product_usecase.dart';
import '../../domain/usecases/products/delete_product_usecase.dart';
import '../../domain/usecases/products/update_product_usecase.dart';

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

  @override
  void dispose() {
    nameController.dispose();
    barcodeController.dispose();
    descriptionController.dispose();
    brandController.dispose();

    super.dispose();
  }

  String? _errorMessage;

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
    _errorMessage = null;
    notifyListeners();

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
      _errorMessage = 'Erro ao cadastrar produto';
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
    );
  }

  void _fillFields(Product product) {
    nameController.text = product.name;
    barcodeController.text = product.barcode;
    brandController.text = product.brand;
    descriptionController.text = product.description ?? '';
    _imagePath = product.imagePath;
  }

  Future<bool> delete() async {
    if (_productReceived?.id == null) {
      return false;
    }

    try {
      await _deleteProductUsecase(_productReceived!.id!);
      return true;
    } catch (e) {
      _errorMessage = 'Erro ao cadastrar produto';
      return false;
    }
  }
}
