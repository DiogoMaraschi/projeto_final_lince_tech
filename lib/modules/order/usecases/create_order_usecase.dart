import 'package:dartz/dartz.dart' hide Order;

import '../../../entities/order/order.dart';
import '../../../entities/profile.dart';
import '../order_failure.dart';
import '../repository.dart';

class CreateOrderUsecase {
  final OrderRepository repository;

  CreateOrderUsecase({required this.repository});

  Future<Either<OrderFailure, int>> call({
    required Order order,
    required Profile? profile,
  }) async {
    if (!_isValidCoordinates(profile)) {
      return const Left(OrderFailure.profileCoordinatesMissing);
    }

    if (!_isOrderValid(order)) {
      return const Left(OrderFailure.invalidOrder);
    }

    return await repository.insert(order);
  }

  bool _isValidCoordinates(Profile? profile) {
    if (profile == null) return false;

    return profile.latitude.isFinite &&
        profile.longitude.isFinite &&
        profile.latitude >= -90 &&
        profile.latitude <= 90 &&
        profile.longitude >= -180 &&
        profile.longitude <= 180;
  }

  bool _isOrderValid(Order order) {
    return order.customerId > 0 &&
        order.carrierId > 0 &&
        order.items.isNotEmpty &&
        order.items.every(
          (item) =>
              item.product.id != null &&
              item.quantity > 0 &&
              item.unitPrice >= 0,
        );
  }
}
