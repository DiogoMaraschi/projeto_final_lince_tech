import 'package:flutter/material.dart';

import '../../camera.dart';
import '../../domain/entities/product.dart';

class ProductController with ChangeNotifier {
  final createProductUsecase;

  ProductController({required this.createProductUsecase});

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
  }

  bool _isLoading = false;
  String? _errorMessage;
  Product? _product;
  String? _imagePath;

  Future<void> takePicture() async {
    _imagePath = await Camera().captureImage();
  }

  Future<void> createProduct() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final product = convertTextToProduct();

    try {
      await createProductUsecase(product);
    } catch (e) {
      _errorMessage = 'Erro ao cadastrar produto';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Product convertTextToProduct() {
    return Product(
      name: nameController.text,
      barcode: barcodeController.text,
      brand: brandController.text,
      imagePath: _imagePath,
    );
  }
}
