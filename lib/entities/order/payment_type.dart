import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

enum PaymentGroup { inFull, installment }

enum PaymentType {
  creditCard(PaymentGroup.installment),
  cash(PaymentGroup.inFull),
  bankTransfer(PaymentGroup.inFull),
  pix(PaymentGroup.inFull);

  const PaymentType(this.group);

  final PaymentGroup group;

  String translate(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return switch (this) {
      creditCard => l10n.paymentTypeCreditCard,
      cash => l10n.paymentTypeCash,
      bankTransfer => l10n.paymentTypeBankTransfer,
      pix => l10n.paymentTypePix,
    };
  }

  String get databaseValue {
    return switch (this) {
      PaymentType.creditCard => 'credit_card',
      PaymentType.cash => 'cash',
      PaymentType.bankTransfer => 'bank_transfer',
      PaymentType.pix => 'pix',
    };
  }

  static PaymentType fromDatabaseValue(String value) {
    return switch (value) {
      'credit_card' => PaymentType.creditCard,
      'cash' => PaymentType.cash,
      'bank_transfer' => PaymentType.bankTransfer,
      'pix' => PaymentType.pix,
      _ => throw ArgumentError('Tipo de pagamento inválido: $value'),
    };
  }
}

class PaymenItem {
  PaymentType paymentType;
  int installments;

  PaymenItem({required this.paymentType, required this.installments});
}
