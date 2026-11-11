import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../entities/carrier.dart';
import '../../../entities/customer/costumer.dart';
import '../../../entities/order/order_item.dart';
import '../../../entities/order/payment_type.dart';
import '../../../main.dart';
import '../../controllers/carrier_list_controller.dart';
import '../../controllers/customer_list_controller.dart';
import '../../controllers/order_details_controller.dart';
import '../../controllers/product_list_controller.dart';
import '../../formatters/app_formatters.dart';
import 'carrier_modal.dart';
import 'customer_modal.dart';
import 'delivery_card.dart';
import 'order_item_draft_card.dart';
import 'payment_type_modal.dart';
import 'product_modal.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Novo Pedido',
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
                      'Cliente',
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
                                    'Selecionar Cliente',
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
                                      AppFormatters.formatCnpj(customer.cnpj),
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
                        'Produtos',
                        style: TextStyle(fontSize: 18, fontWeight: .w700),
                      ),
                      Text(
                        '+ Adicionar produto',
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
                                  'Nenhum produto cadastrado',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: .w900,
                                  ),
                                ),
                                Text(
                                  'Adicione os itens que o cliente solicitou',
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
                                    '+ Adicionar Produto',
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
                          return OrderItemDraftCard(
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
                      'Transportadora',
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
                                    'Selecionar Transportadora',
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
                                          '${AppFormatters.formatMoney(carrier.costPerKm)}/km',
                                        ),
                                        Text(
                                          '- mín. ${AppFormatters.formatMoney(carrier.minimumPrice)}',
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
                      'Endereço de entrega',
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
                      'Forma de Pagamento',
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
                                Selector<OrderDetailsController, PaymenItem?>(
                                  selector: (context, controller) {
                                    return controller.selectedPaymentItem;
                                  },
                                  builder: (context, paymentItem, child) {
                                    if (paymentItem == null) {
                                      return Text(
                                        'Selecionar Forma de Pagamento',
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
                                            Text('- Parcelas'),
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
                      'Resumo do Pedido',
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
                            ? 'Distância não calculada'
                            : '${(controller.deliveryDistance! / 1000).toStringAsFixed(2)} km × '
                                  '${AppFormatters.formatMoney(controller.selectedCarrier!.costPerKm)}/km · '
                                  'mínimo ${AppFormatters.formatMoney(controller.selectedCarrier!.minimumPrice)}';

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal dos produtos',
                                  style: TextStyle(
                                    color: Color(0xFFA0AAB8),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  AppFormatters.formatMoney(
                                    controller.productsSubtotal,
                                  ),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Color(0xFFA0AAB8),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Descontos',
                                  style: TextStyle(
                                    color: Color(0xFFA0AAB8),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  AppFormatters.formatMoney(
                                    controller.totalDiscount,
                                  ),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Color(0xFF829BFF),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Entrega',
                                  style: TextStyle(
                                    color: Color(0xFFA0AAB8),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  AppFormatters.formatMoney(
                                    controller.deliveryValue,
                                  ),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Color(0xFFA0AAB8),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                distanceText,
                                style: TextStyle(
                                  color: Color(0xFFA0AAB8),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(height: 1),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                      color: Color(0xFFF0F2F5),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    AppFormatters.formatMoney(
                                      controller.orderTotal,
                                    ),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFFF0F2F5),
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
                      'Observações de Pagamento',
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
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Observações do pagamento',
                        hintText: 'Adicione uma observação',
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
                      'Observações',
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
                          .notesController,
                      maxLines: 3,
                      maxLength: 90,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Observações do pedido',
                        hintText: 'Adicione uma observação',
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total'),
                      Text(
                        AppFormatters.formatMoney(
                          context.watch<OrderDetailsController>().orderTotal,
                        ),
                        style: TextStyle(fontSize: 20, fontWeight: .w700),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: Size(230, 60),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Salvar pedido'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
