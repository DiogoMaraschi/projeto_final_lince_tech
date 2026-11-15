import 'package:flutter/material.dart';

import '../../../entities/order/order_summary.dart';
import '../../../modules/order/usecases/get_all_order_summaries_usecase.dart';

class OrderListController with ChangeNotifier{
  final GetAllOrderSummariesUsecase getAllOrderSummariesUsecase;

  OrderListController({required this.getAllOrderSummariesUsecase});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<OrderSummary> _orderSummary = [];

  List<OrderSummary> get orderSummary => List.unmodifiable(_orderSummary);

  Future<void> getAllOrderSummary() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await getAllOrderSummariesUsecase();

      _orderSummary = result;

    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }
}