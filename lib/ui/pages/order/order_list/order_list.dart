import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../entities/order/order.dart';
import '../../../../entities/order/order_item.dart';
import '../../../../entities/order/payment_type.dart';
import '../../../../entities/product.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../main.dart';
import '../../../controllers/order/order_list_controller.dart';
import '../order_details.dart';
import 'order_list_card.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderListController(
        getAllOrderSummariesUsecase: injection.getAllOrderSummariesUsecase,
      )..getAllOrderSummary(),
      child: const _OrderListPage(),
    );
  }
}

class _OrderListPage extends StatelessWidget {
  const _OrderListPage();

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderListController>(
      builder: (context, controller, child) {
        final l10n = AppLocalizations.of(context);

        return Scaffold(
          appBar: AppBar(title: Text('Pedidos')),
          body: controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : controller.orderSummary.isEmpty
              ? Center(child: Text('Nenhum pedido foi encontrado'))
              : ListView.builder(
                  padding: const EdgeInsetsGeometry.all(16),
                  itemCount: controller.orderSummary.length,
                  itemBuilder: (context, index) {
                    final orderSummary = controller.orderSummary[index];
                    return OrderListCard(
                      orderSummary: orderSummary,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderDetailsPage(orderId: orderSummary.id),
                          ),
                        );
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderDetailsPage()),
              );

              if (!context.mounted) return;

              controller.getAllOrderSummary();
            },
            backgroundColor: const Color(0xFF4F46E5),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(Icons.add, size: 28),
          ),
        );
      },
    );
  }
}
