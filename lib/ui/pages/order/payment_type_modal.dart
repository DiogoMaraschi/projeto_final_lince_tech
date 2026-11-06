import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/order/payment_type.dart';
import '../../../entities/product.dart';
import '../../controllers/order_details_controller.dart';
import '../../controllers/product_list_controller.dart';

Future<void> showPaymentTypeModal(BuildContext context) async {
  final colors = Theme.of(context).colorScheme;
  final height = MediaQuery.sizeOf(context).height;

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
                Expanded(
                  child: Column(
                    children: [
                      for (final type in PaymentType.values)
                        ListTile(
                          title: Text(type.translate(modalContext)),
                          trailing: Icon(
                            selectedPaymentType == type
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                          ),
                          onTap: () {
                            setModalState(() {
                              selectedPaymentType = type;
                              if (type != PaymentType.creditCard) {
                                installments = 1;
                              }
                            });
                          },
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
