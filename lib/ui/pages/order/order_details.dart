import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/carrier.dart';
import '../../../entities/costumer.dart';
import '../../../entities/order_item_draft.dart';
import '../../../main.dart';
import '../../app_colors.dart';
import '../../controllers/carrier_list_controller.dart';
import '../../controllers/customer_list_controller.dart';
import '../../controllers/order_details_controller.dart';
import '../../controllers/product_list_controller.dart';
import '../../formatters/app_formatters.dart';
import '../../widgets/order_item_draft_card.dart';
import 'carrier_modal.dart';
import 'customer_modal.dart';
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
          ),
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
                  child: Selector<OrderDetailsController, List<OrderItemDraft>>(
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
                            onDecrement: () => orderController.decrementProduct(
                              productId,
                            ),
                            onIncrement: () => orderController.incrementProduct(
                              productId,
                            ),
                            onRemove: () => orderController.deleteProduct(
                              productId,
                            ),
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
                Material(
                  color: colors.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    side: BorderSide(color: Colors.white12),
                  ),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          //TODO COLOCAR MAPS E ENDERECO
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
