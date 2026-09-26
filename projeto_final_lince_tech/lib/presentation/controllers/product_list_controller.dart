import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import '../../domain/usecases/products/get_products_usecase.dart';

class ProductListController with ChangeNotifier {
  final GetProductsUsecase _getProductsUsecase;

  ProductListController({required this._getProductsUsecase});

  bool _isLoading = false;
  String? _errorMessage;

  List<Product> _products = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Product> get products => List.unmodifiable(_products);

  Future<void> getProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _getProductsUsecase();

      print('PRODUTOS VINDOS DO USECASE: $result');
      print('QUANTIDADE: ${result.length}');

      _products = result;
    } catch (e) {
      print('ERRO AO BUSCAR PRODUTOS: $e');
      _errorMessage = 'Erro ao obter produtos';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
