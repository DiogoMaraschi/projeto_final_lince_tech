import 'payment_type.dart';

class Order {
  final int? id;
  final int customerId;
  final int carrierId;
  final PaymenItem paymenItem;
  final double freight;
  final String? paymentNotes;
  final String? generalNotes;
  final String created_at;
  final String? deleted_at;

  Order({
    this.id,
    required this.customerId,
    required this.carrierId,
    required this.paymenItem,
    required this.freight,
    this.paymentNotes,
    this.generalNotes,
    required this.created_at,
    this.deleted_at,
  });


}
