import '../../../entities/order/payment_type.dart';

class CalculatePaymentTotalUsecase {
  double call(PaymenItem paymentItem, double orderTotal) {
    if (paymentItem.paymentType == PaymentType.creditCard &&
        paymentItem.installments > 1)
      return (orderTotal * 1.04);

    return orderTotal;
  }
}
