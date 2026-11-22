import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../entities/order/order.dart';
import '../../../../entities/order/order_item.dart';
import '../../../../entities/order/payment_type.dart';
import '../../../../entities/product.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../main.dart';
import '../../../controllers/order/order_list_controller.dart';
import '../order_details/order_details.dart';
import '../pdf/order_pdf_preview.dart';
import 'order_list_card.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderListController(
        getAllOrderSummariesUsecase: injection.getAllOrderSummariesUsecase,
        getOrderForEditingUsecase: injection.getOrderForEditingUsecase,
        generateOrderPdfUsecase: injection.generateOrderPdfUsecase,
        getProfileUsecase: injection.getProfileUsecase,
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
        final l10n = AppLocalizations.of(context)!;

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.orderListTitle),
          ),
          body: controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : controller.orderSummary.isEmpty
              ? Center(
                  child: Text(AppLocalizations.of(context)!.orderListEmpty),
                )
              : ListView.builder(
                  padding: const EdgeInsetsGeometry.all(16),
                  itemCount: controller.orderSummary.length,
                  itemBuilder: (context, index) {
                    final orderSummary = controller.orderSummary[index];
                    return OrderListCard(
                      orderSummary: orderSummary,

                      onGeneratePdf: () async {
                        final primaryColorArgb =
                            Theme.of(context).colorScheme.primary.toARGB32();

                        final bytes = await controller.generatePdf(
                          orderSummary.id,
                          primaryColorArgb,
                        );

                        if (!context.mounted) return;

                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderPdfPreview(pdfBytes: bytes),
                          ),
                        );
                      },
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              print('id na lista ${orderSummary.id}');
                              return OrderDetailsPage(orderId: orderSummary.id);
                            },
                          ),
                        );
                        if (!context.mounted) return;

                        await controller.getAllOrderSummary();
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
