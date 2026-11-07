import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/order/payment_type.dart';
import '../../controllers/order_details_controller.dart';
import '../../formatters/app_formatters.dart';

Future<void> showPaymentTypeModal(BuildContext context) async {
  final colors = Theme.of(context).colorScheme;
  final height = MediaQuery.sizeOf(context).height;

  final inFullTypes = PaymentType.values
      .where((type) => type.group == PaymentGroup.inFull)
      .toList();

  final installmentTypes = PaymentType.values
      .where((type) => type.group == PaymentGroup.installment)
      .toList();

  IconData paymentIcon(PaymentType type) {
    return switch (type) {
      PaymentType.pix => Icons.qr_code,
      PaymentType.cash => Icons.payments_outlined,
      PaymentType.bankTransfer => Icons.account_balance_outlined,
      PaymentType.creditCard => Icons.credit_card_outlined,
    };
  }

  PaymenItem? selectedPaymentItem;

  PaymentType? selectedPaymentType;
  int installments = 1;
  double purchaseValue = 10000;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: colors.surface,
    showDragHandle: true,
    builder: (modalContext) {
      return StatefulBuilder(
        builder: (modalContext, setModalState) {
          return SizedBox(
            height: height * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 12, 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Selecionar forma de pagamento',
                            style: Theme.of(modalContext).textTheme.titleLarge,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(modalContext),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  Column(
                    children: [
                      Text(
                        'A vista',
                        style: TextStyle(fontSize: 22, fontWeight: .w600),
                      ),

                      Padding(
                        padding: const EdgeInsetsGeometry.all(10),
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16),
                            side: BorderSide(color: Colors.white12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final type in inFullTypes)
                                Column(
                                  children: [
                                    ListTile(
                                      minTileHeight: 70,
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: colors.surfaceContainer,
                                          borderRadius:
                                              BorderRadiusGeometry.circular(12),
                                        ),
                                        child: Icon(paymentIcon(type)),
                                      ),
                                      title: Text(type.translate(modalContext)),
                                      selected: selectedPaymentType == type,
                                      trailing: Radio<PaymentType>(
                                        value: type,
                                        groupValue: selectedPaymentType,
                                        onChanged: (value) {
                                          if (value == null) return;

                                          setModalState(() {
                                            selectedPaymentType = value;
                                            installments = 1;
                                          });
                                        },
                                      ),
                                      onTap: () {
                                        setModalState(() {
                                          selectedPaymentType = type;
                                          installments = 1;
                                        });
                                      },
                                      selectedTileColor: colors.inversePrimary,
                                    ),

                                    if (type != inFullTypes.last)
                                      Divider(height: 1),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Parcelado',
                        style: TextStyle(fontSize: 22, fontWeight: .w600),
                      ),

                      Padding(
                        padding: const EdgeInsetsGeometry.all(10),
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16),
                            side: BorderSide(color: Colors.white12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: .max,
                            children: [
                              for (final type in installmentTypes)
                                Column(
                                  children: [
                                    ListTile(
                                      minTileHeight: 70,
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: colors.surfaceContainer,
                                          borderRadius:
                                              BorderRadiusGeometry.circular(12),
                                        ),
                                        child: Icon(paymentIcon(type)),
                                      ),
                                      title: Text(type.translate(modalContext)),
                                      trailing: IconButton(
                                        icon: Icon(
                                          selectedPaymentType == type
                                              ? Icons.keyboard_arrow_up_outlined
                                              : Icons
                                                    .keyboard_arrow_down_outlined,
                                          size: 34,
                                        ),
                                        onPressed: () {
                                          selectedPaymentType != type
                                              ? setModalState(
                                                  () => selectedPaymentType =
                                                      type,
                                                )
                                              : setModalState(
                                                  () => selectedPaymentType =
                                                      null,
                                                );
                                        },
                                      ),
                                      onTap: () {
                                        selectedPaymentType != type
                                            ? setModalState(
                                                () =>
                                                    selectedPaymentType = type,
                                              )
                                            : setModalState(
                                                () =>
                                                    selectedPaymentType = null,
                                              );
                                      },
                                      selectedTileColor: colors.inversePrimary,
                                    ),

                                    if (type != inFullTypes.last)
                                      Divider(height: 1),
                                  ],
                                ),

                              if (installmentTypes.contains(
                                selectedPaymentType,
                              ))
                                ListView.builder(
                                  itemCount: 10,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    final index = i + 1;
                                    return ListTile(
                                      selected: installments == index,
                                      title: Text(
                                        '${index}x de ${AppFormatters.formatMoney(purchaseValue / index)}',
                                      ),
                                      onTap: () => setModalState(
                                        () => installments = index,
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (selectedPaymentType != null)
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsetsGeometry.fromLTRB(
                          16,
                          8,
                          16,
                          16,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Concluir',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    },
  );

  if (!context.mounted || installments < 1 || selectedPaymentType == null)
    return;

  final paymentItem = PaymenItem(
    paymentType: selectedPaymentType!,
    installments: installments,
  );

  print('parcelas $installments');

  context.read<OrderDetailsController>().selectPaymentItem(paymentItem);
}
