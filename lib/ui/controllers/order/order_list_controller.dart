import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../entities/order/order_summary.dart';
import '../../../modules/order/usecases/generate_order_pdf_usecase.dart';
import '../../../modules/order/usecases/get_all_order_summaries_usecase.dart';
import '../../../modules/order/usecases/get_order_for_editing_usecase.dart';

class OrderListController with ChangeNotifier {
  final GetAllOrderSummariesUsecase getAllOrderSummariesUsecase;
  final GenerateOrderPdfUsecase generateOrderPdfUsecase;
  final GetOrderForEditingUsecase getOrderForEditingUsecase;

  OrderListController({
    required this.getAllOrderSummariesUsecase,
    required this.generateOrderPdfUsecase,
    required this.getOrderForEditingUsecase,
  });

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

  Future<Uint8List> generatePdf(int orderId) async{
    final order = await getOrderForEditingUsecase(orderId);

    return await generateOrderPdfUsecase(order!);
  }
}
