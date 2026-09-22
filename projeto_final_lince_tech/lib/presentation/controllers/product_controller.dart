import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/capture_image_usecase.dart';
import '../../domain/usecases/products/create_product_usecase.dart';

class ProductController with ChangeNotifier {
  final CreateProductUsecase _createProductUsecase;
  final CaptureImageUsecase _captureImageUsecase;

  ProductController({
    required this._createProductUsecase,
    required this._captureImageUsecase,
  });

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

  bool _isLoading = false;
  String? _errorMessage;
  Product? _product;

  String? _imagePath;
  String? get imagePath => _imagePath;

  Future<void> captureImage() async {
    final path = await _captureImageUsecase();

    if (path != null) {
      _imagePath = path;
      notifyListeners();
    }
  }

  Future<bool> insertProduct() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _product = convertTextToProduct();

    try {
      await _createProductUsecase(_product!);
      return true;
    } catch (e) {
      _errorMessage = 'Erro ao cadastrar produto';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Product convertTextToProduct() {
    return Product(
      name: nameController.text,
      barcode: barcodeController.text,
      description: descriptionController.text,
      brand: brandController.text,
      imagePath: _imagePath,
    );
  }
}
