import 'dart:typed_data';

import '../../../entities/order/order_edit_data.dart';
import '../../../entities/profile.dart';
import '../services/order_pdf_generator.dart';

class GenerateOrderPdfUsecase {
  final OrderPdfGenerator _generator;

  GenerateOrderPdfUsecase({required this._generator});

  Future<Uint8List> call(OrderEditData order, Profile profile) {
    return _generator.generate(order, profile);
  }
}
