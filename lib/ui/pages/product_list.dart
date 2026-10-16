import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../controllers/product_list_controller.dart';
import '../widgets/product_card.dart';
import 'product_details.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductListController(
        getProductsUsecase: injection.getAllProductsUsecase,
      )..getProducts(),
      child: const _ProductListPage(),
    );
  }
}

class _ProductListPage extends StatelessWidget {
  const _ProductListPage();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListController>(
      builder: (context, state, child) {
        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          appBar: AppBar(title: Text(l10n.productListTitle)),
          body: state.products.isEmpty
              ? Center(child: Text(l10n.productListEmpty))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductCard(
                      product: product,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsPage(product: product),
                          ),
                        );
                        if (!context.mounted) return;

                        await state.getProducts();
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailsPage()),
              );
              if (!context.mounted) return;

              await state.getProducts();
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
