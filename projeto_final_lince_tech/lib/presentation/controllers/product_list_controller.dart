import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/products/get_products_usecase.dart';

class ProductListController with ChangeNotifier {
  final GetProductsUsecase _getProductsUsecase;

  ProductListController({required this._getProductsUsecase});

  bool _isLoading = false;
  String? _errorMessage;
  Product? _product;
  List<Product> _products = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Product? get product => _product;
  List<Product> get products => List.unmodifiable(_products);

  Future<List<Product>?> getProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    _products.clear();

    try {
      _products = await _getProductsUsecase();
      return products;
    } catch (e) {
      _errorMessage = 'Erro ao obter produtos';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
