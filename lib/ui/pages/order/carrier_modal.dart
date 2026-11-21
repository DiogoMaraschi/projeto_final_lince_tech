import 'package:flutter/material.dart';
import '../../../core/formatters/display_formatters.dart';
import '../../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../controllers/carrier/carrier_list_controller.dart';
import '../../controllers/order/order_details_controller.dart';
import '../../formatters/input_formatters.dart';

Future<void> showCarrierModal(BuildContext context) async {
  final colors = Theme.of(context).colorScheme;
  final height = MediaQuery.sizeOf(context).height;

  final carrierController = context.read<CarrierListController>();

  final carrierFuture = carrierController.getAllCarriers();

  final carrierId = await showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: colors.surface,
    showDragHandle: true,
    builder: (modalContext) {
      final l10n = AppLocalizations.of(modalContext)!;
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
                      l10n.orderSelectCarrier,
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: l10n.orderSearchCarrier,
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: colors.surfaceContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: FutureBuilder<void>(
                future: carrierFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(l10n.orderCarriersLoadError));
                  }

                  final carriers = carrierController.carriers;

                  if (carriers.isEmpty) {
                    return Center(child: Text(l10n.orderNoCarriers));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: carriers.length,
                    itemBuilder: (context, index) {
                      final carrier = carriers[index];

                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.local_shipping_outlined),
                        ),
                        title: Text(carrier.name),
                        subtitle: Row(
                          children: [
                            Text(
                              '${DisplayFormatters.formatMoney(carrier.costPerKm)}/km',
                            ),
                            Text(
                              '${l10n.carrierMinimumShort} ${DisplayFormatters.formatMoney(carrier.minimumPrice)}',
                            ),
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pop(modalContext, carrier.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );

  if (!context.mounted || carrierId == null) return;

  await context.read<OrderDetailsController>().selectCarrier(carrierId);
}
