import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../entities/order/order_summary.dart';
import '../../../modules/order/order_failure.dart';
import '../../../modules/order/usecases/generate_order_pdf_usecase.dart';
import '../../../modules/order/usecases/get_all_order_summaries_usecase.dart';
import '../../../modules/order/usecases/get_order_for_editing_usecase.dart';
import '../../../modules/profile/usecases/get_profile_usecase.dart';

class OrderListController with ChangeNotifier {
  final GetAllOrderSummariesUsecase getAllOrderSummariesUsecase;
  final GenerateOrderPdfUsecase generateOrderPdfUsecase;
  final GetOrderForEditingUsecase getOrderForEditingUsecase;
  final GetProfileUsecase getProfileUsecase;

  OrderListController({
    required this.getAllOrderSummariesUsecase,
    required this.generateOrderPdfUsecase,
    required this.getOrderForEditingUsecase,
    required this.getProfileUsecase,
  });

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  OrderSummaryFailure? error;

  List<OrderSummary> _orderSummary = [];

  List<OrderSummary> get orderSummary => List.unmodifiable(_orderSummary);

  Future<void> getAllOrderSummary() async {
    _isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await getAllOrderSummariesUsecase();


      result.fold(
        (failure) {
          error = failure;
        },
        (list) {
          _orderSummary = list;
          error = null;
        },
      );
    } on Exception catch (e) {
      debugPrint('Erro $e');
      error = OrderSummaryFailure.orderSummariesLoadFailed;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Uint8List> generatePdf(int orderId, int primaryColorArgb) async {
    final order = await getOrderForEditingUsecase(orderId);
    final profile = await getProfileUsecase();

    if (order == null) {
      throw StateError('Pedido não encontrado.');
    }

    if (profile == null) {
      throw StateError(
        'Cadastre o perfil da loja antes de gerar o comprovante.',
      );
    }

    return await generateOrderPdfUsecase(order, profile, primaryColorArgb);
  }
}
