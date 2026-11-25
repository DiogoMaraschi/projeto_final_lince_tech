import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../core/formatters/display_formatters.dart';
import '../../../../entities/carrier.dart';
import '../../../../entities/customer/costumer.dart';
import '../../../../entities/order/order_item.dart';
import '../../../../entities/order/payment_type.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../main.dart';
import '../../../../modules/order/order_failure.dart';
import '../../../controllers/carrier/carrier_list_controller.dart';
import '../../../controllers/customer/customer_list_controller.dart';
import '../../../controllers/order/order_details_controller.dart';
import '../../../controllers/product/product_list_controller.dart';
import '../../../widgets/error_dialog.dart';
import 'cards/delivery_card.dart';
import 'cards/order_item_card.dart';
import 'modal/carrier_modal.dart';
import 'modal/customer_modal.dart';
import 'modal/payment_type_modal.dart';
import 'modal/product_modal.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, this.orderId});

  final int? orderId;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OrderDetailsController(
            getCustomerByIdUsecase: injection.getCustomerByIdUsecase,
            getCarrierByIdUsecase: injection.getCarrierByIdUsecase,
            getDrivingRouteUsecase: injection.getDrivingRouteUsecase,
            getProfileUsecase: injection.getProfileUsecase,
            calculatePaymentTotalUsecase:
                injection.calculatePaymentTotalUsecase,
            getInstallmentsUsecase: injection.getInstallmentsUsecase,
            createOrderUsecase: injection.createOrderUsecase,
            getOrderForEditingUsecase: injection.getOrderForEditingUsecase,
            updateOrderUsecase: injection.updateOrderUsecase,
            deleteOrderUsecase: injection.deleteOrderUsecase,
            orderId: orderId,
          )..getProfile(),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomerListController(
            getAllCustomersUsecase: injection.getAllCustomersUsecase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CarrierListController(
            getAllCarriersUsecase: injection.getAllCarriersUsecase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductListController(
            getProductsUsecase: injection.getAllProductsUsecase,
          ),
        ),
      ],
      child: _OrderDetailsPage(),
    );
  }
}

class _OrderDetailsPage extends StatelessWidget {
  const _OrderDetailsPage();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.watch<OrderDetailsController>().isEditing
                  ? l10n.orderEdit
                  : l10n.orderTitleNew,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: colors.primary,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: colors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'PED-0004',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Column(
        children: [
          Divider(height: 1),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
              children: [
                Container(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.orderCustomer,
                      style: TextStyle(fontSize: 18, fontWeight: .w700),
                    ),
                  ),
                ),

                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: InkWell(
                    onTap: () => showCustomerModal(context),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6ECF8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.storefront_outlined,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(width: 12),

                          Expanded(
                            child: Selector<OrderDetailsController, Customer?>(
                              selector: (context, controller) {
                                return controller.selectedCustomer;
                              },
                              builder: (context, customer, child) {
                                if (customer == null) {
                                  return Text(
                                    l10n.orderSelectCustomerUpper,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: .w700,
                                    ),
                                  );
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(customer.name),
                                    Text(
                                      DisplayFormatters.formatCnpj(
                                        customer.cnpj,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.orderProducts,
                        style: TextStyle(fontSize: 18, fontWeight: .w700),
                      ),
                      Text(
                        '+ ${l10n.orderAddProduct}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w700,
                          color: colors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: Selector<OrderDetailsController, List<OrderItem>>(
                    selector: (context, controller) =>
                        controller.selectedProducts,
                    builder: (context, selectedProducts, child) {
                      final orderController = context
                          .read<OrderDetailsController>();

                      if (selectedProducts.isEmpty) {
                        return InkWell(
                          onTap: () => showProductModal(context),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Icon(Icons.storage_outlined),
                                const SizedBox(height: 5),
                                Text(
                                  l10n.orderNoProducts,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: .w900,
                                  ),
                                ),
                                Text(
                                  l10n.orderNoProductsHint,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: .w200,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                    10,
                                    8,
                                    10,
                                    8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white12),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '+ ${l10n.orderAddProductUpper}',
                                    style: TextStyle(fontWeight: .w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: selectedProducts.map((itemDraft) {
                          final productId = itemDraft.product.id!;
                          return OrderItemCard(
                            product: itemDraft.product,
                            quantity: itemDraft.quantity,
                            onDecrement: () =>
                                orderController.decrementProduct(productId),
                            onIncrement: () =>
                                orderController.incrementProduct(productId),
                            onRemove: () =>
                                orderController.deleteProduct(productId),
                            onDiscountChanged: (value) {
                              context
                                  .read<OrderDetailsController>()
                                  .setItemDiscount(
                                    productId: itemDraft.product.id!,
                                    percent: value,
                                  );
                            },
                            discountPercent: itemDraft.discountPercent,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.orderCarrier,
                      style: TextStyle(fontSize: 18, fontWeight: .w700),
                    ),
                  ),
                ),

                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: InkWell(
                    onTap: () => showCarrierModal(context),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6ECF8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.local_shipping_outlined,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(width: 12),

                          Expanded(
                            child: Selector<OrderDetailsController, Carrier?>(
                              selector: (context, controller) {
                                return controller.selectedCarrier;
                              },
                              builder: (context, carrier, child) {
                                if (carrier == null) {
                                  return Text(
                                    l10n.orderSelectCarrierUpper,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: .w700,
                                    ),
                                  );
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(carrier.name),
                                    Row(
                                      children: [
                                        Text(
                                          '${DisplayFormatters.formatMoney(carrier.costPerKm)}/km',
                                        ),
                                        Text(
                                          '${l10n.carrierMinimumShort} ${DisplayFormatters.formatMoney(carrier.minimumPrice)}',
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                Container(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.orderDeliveryAddress,
                      style: TextStyle(fontSize: 18, fontWeight: .w700),
                    ),
                  ),
                ),

                Consumer<OrderDetailsController>(
                  builder: (context, controller, child) {
                    final profile = controller.profile;
                    final customer = controller.selectedCustomer;

                    if (profile == null || customer == null) {
                      return const SizedBox.shrink();
                    }

                    return DeliveryCard(
                      setController: controller.setController,
                      storeLocation: LatLng(
                        profile.latitude,
                        profile.longitude,
                      ),
                      customerLocation: LatLng(
                        customer.latitude,
                        customer.longitude,
                      ),
                      deliveryDistance: controller.deliveryDistance,
                      customerAddress: controller.getCustomerAddress(),
                      points: controller.geoPoints,
                    );
                  },
                ),

                const SizedBox(height: 15),

                Container(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.orderPaymentType,
                      style: TextStyle(fontSize: 18, fontWeight: .w700),
                    ),
                  ),
                ),

                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: InkWell(
                    onTap: () =>
                        context
                            .read<OrderDetailsController>()
                            .selectedProducts
                            .isEmpty
                        ? null
                        : showPaymentTypeModal(context),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6ECF8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.payment_outlined,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(width: 12),

                          Expanded(
                            child:
                                Selector<OrderDetailsController, PaymentItem?>(
                                  selector: (context, controller) {
                                    return controller.selectedPaymentItem;
                                  },
                                  builder: (context, paymentItem, child) {
                                    if (paymentItem == null) {
                                      return Text(
                                        l10n.orderSelectPaymentUpper,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: .w700,
                                        ),
                                      );
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(paymentItem.paymentType.name),
                                        Row(
                                          children: [
                                            Text(
                                              paymentItem.installments
                                                  .toString(),
                                            ),
                                            Text(l10n.orderInstallments),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.orderSummary,
                      style: TextStyle(fontSize: 18, fontWeight: .w700),
                    ),
                  ),
                ),

                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(12),
                    child: Consumer<OrderDetailsController>(
                      builder: (context, controller, child) {
                        final distanceText =
                            controller.deliveryDistance == null ||
                                controller.selectedCarrier == null
                            ? l10n.orderDistanceNotCalculated
                            : l10n.orderDeliveryCalculation(
                                (controller.deliveryDistance! / 1000)
                                    .toStringAsFixed(2),
                                DisplayFormatters.formatMoney(
                                  controller.selectedCarrier!.costPerKm,
                                ),
                                DisplayFormatters.formatMoney(
                                  controller.selectedCarrier!.minimumPrice,
                                ),
                              );

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.orderSubtotalProducts,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  DisplayFormatters.formatMoney(
                                    controller.productsSubtotal,
                                  ),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.orderDelivery,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  DisplayFormatters.formatMoney(
                                    controller.deliveryValue,
                                  ),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                distanceText,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),

                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.orderPaymentFee,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  DisplayFormatters.formatMoney(
                                    controller.additionalFee,
                                  ),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  l10n.orderDiscounts,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: colors.primary,
                                  ),
                                ),
                                Text(
                                  DisplayFormatters.formatMoney(
                                    controller.totalDiscount,
                                  ),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: colors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(height: 1),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    l10n.orderTotal,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    DisplayFormatters.formatMoney(
                                      controller.orderTotal,
                                    ),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.orderPaymentNotesTitle,
                      style: TextStyle(fontSize: 18, fontWeight: .w700),
                    ),
                  ),
                ),

                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(8),
                    child: TextFormField(
                      controller: context
                          .read<OrderDetailsController>()
                          .paymentNotesController,
                      maxLines: 3,
                      maxLength: 90,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: l10n.orderPaymentNotesLabel,
                        hintText: l10n.orderNotesHint,
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Container(
                  height: 44,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.orderNotesTitle,
                      style: TextStyle(fontSize: 18, fontWeight: .w700),
                    ),
                  ),
                ),

                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(8),
                    child: TextFormField(
                      controller: context
                          .read<OrderDetailsController>()
                          .generalNotesController,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: l10n.orderNotesLabel,
                        hintText: l10n.orderNotesHint,
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1),
        ],
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.orderTotal),
                      Text(
                        DisplayFormatters.formatMoney(
                          context.watch<OrderDetailsController>().orderTotal,
                        ),
                        style: TextStyle(fontSize: 20, fontWeight: .w700),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Consumer<OrderDetailsController>(
                    builder: (context, controller, child) {
                      return Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                minimumSize: Size(0, 60),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () async {
                                if (!controller.verifyEntities()) {
                                  await showDialog<void>(
                                    context: context,
                                    builder: (dialogContext) {
                                      return AlertDialog(
                                        title: Text(l10n.commonWarning),
                                        content: Text(l10n.commonFillRequired),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(dialogContext),
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return;
                                }

                                final saved = await controller.saveOrder();

                                if (!context.mounted) return;

                                if (saved) {
                                  Navigator.pop(context);
                                } else {
                                  final message = switch (controller.error) {
                                    OrderFailure.invalidOrder =>
                                      l10n.invalidOrder,
                                    OrderFailure.deliveryNotCalculated =>
                                      l10n.deliveryNotCalculated,
                                    OrderFailure.profileCoordinatesMissing =>
                                      l10n.profileCoordinatesMissing,
                                    OrderFailure.saveFailed =>
                                      l10n.orderSaveFailed,
                                    OrderFailure.orderNotFound =>
                                      l10n.orderNotFound,
                                    null => l10n.orderSaveFailed,
                                  };

                                  await showErrorDialog(
                                    context,
                                    message: message,
                                  );
                                }
                              },
                              child: controller.isEditing
                                  ? Text(l10n.orderEdit)
                                  : Text(l10n.orderSave),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (context
                              .read<OrderDetailsController>()
                              .isEditing) ...[
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(0, 60),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                ),
                                icon: const Icon(Icons.delete_outline),
                                label: Text(l10n.orderDelete),
                                onPressed: () async {
                                  final success = await controller
                                      .deleteOrder();

                                  if (!context.mounted) return;

                                  if (success) {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
