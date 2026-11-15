import '../carrier.dart';
import '../customer/costumer.dart';
import 'order.dart';

class OrderEditData {
  final Order order;
  final Carrier carrier;
  final Customer customer;

  OrderEditData({
    required this.order,
    required this.customer,
    required this.carrier,
  });
}
