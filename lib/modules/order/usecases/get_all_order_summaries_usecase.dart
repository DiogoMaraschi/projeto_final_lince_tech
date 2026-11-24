import 'package:dartz/dartz.dart';

import '../../../entities/order/order_summary.dart';
import '../order_failure.dart';
import '../repository.dart';

class GetAllOrderSummariesUsecase {
  final OrderRepository repository;

  GetAllOrderSummariesUsecase({required this.repository});

  Future<Either<OrderSummaryFailure, List<OrderSummary>>> call() async {
    return await repository.getAllOrderSummaries();
  }
}
