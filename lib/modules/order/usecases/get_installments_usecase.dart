import '../../../entities/order/payment_type.dart';

class GetInstallmentsUsecase {

  int call(PaymentType paymentType, double orderTotal) {
    switch (paymentType) {
      case PaymentType.creditCard:
        if (orderTotal <= 1000) return 1;
        if (orderTotal <= 5000) return 10;
        return 18;

      case PaymentType.cash:
      case PaymentType.bankTransfer:
      case PaymentType.pix:
        return 1;
    }
  }
}
