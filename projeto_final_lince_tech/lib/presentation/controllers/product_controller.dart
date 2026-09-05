import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/products/create_product_usecase.dart';

class ProductController with ChangeNotifier {
  final CreateProductUsecase createProductUsecase;

  ProductController({required this.createProductUsecase});

  bool _isLoading = false;
  String? _errorMessage;
  Product? _product;

  Future<void> createProduct(Product product) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await createProductUsecase(product);
    } catch (e) {
      _errorMessage = 'Erro ao cadastrar produto';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
