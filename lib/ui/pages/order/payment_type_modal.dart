import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/order/payment_type.dart';
import '../../../entities/product.dart';
import '../../controllers/order_details_controller.dart';
import '../../controllers/product_list_controller.dart';

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

  PaymentType? selectedPaymentType;
  int installments = 1;

  final selectedQuantitiesMap = await showModalBottomSheet<Map<int, int>>(
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

                Text('A vista'),

                Padding(
                  padding: const EdgeInsetsGeometry.all(10),
                  child: Material(
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
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: colors.surfaceContainer,
                                    borderRadius: BorderRadiusGeometry.circular(
                                      12,
                                    ),
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

                              if (type != inFullTypes.last) Divider(height: 1),
                            ],
                          ),

                        if (selectedPaymentType == PaymentType.creditCard)
                          DropdownButton<int>(
                            value: installments,
                            items: [1, 2, 3, 4, 5, 6].map((number) {
                              return DropdownMenuItem(
                                value: number,
                                child: Text(
                                  '$number parcela${number == 1 ? '' : 's'}',
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setModalState(() => installments = value);
                            },
                          ),
                      ],
                    ),
                  ),
                ),

                if (selectedPaymentType != null)
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsetsGeometry.fromLTRB(16, 8, 16, 16),
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
          );
        },
      );
    },
  );

  if (!context.mounted ||
      selectedQuantitiesMap == null ||
      selectedQuantitiesMap.isEmpty)
    return;

  // final productsCompleteList = productController.products;
  //
  // context.read<OrderDetailsController>().selectProducts(
  //   productsCompleteList: productsCompleteList,
  //   quantities: selectedQuantitiesMap,
  // );
}
