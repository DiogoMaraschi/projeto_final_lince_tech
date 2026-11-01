import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/product.dart';
import '../../controllers/order_details_controller.dart';
import '../../controllers/product_list_controller.dart';

Future<void> showProductModal(BuildContext context) async {
  final colors = Theme.of(context).colorScheme;
  final height = MediaQuery.sizeOf(context).height;

  final productController = context.read<ProductListController>();
  final productFuture = productController.getProducts();

  Map<int, int> selectedQuantitiesInModal = <int, int>{};

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
                          'Selecionar produtos',
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
                      hintText: 'Buscar por nome ou EAN',
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
                    future: productFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Erro ao carregar produtos'),
                        );
                      }

                      final productsInModal = productController.products;

                      if (productsInModal.isEmpty) {
                        return const Center(
                          child: Text('Nenhum produto cadastrado'),
                        );
                      }

                      return ListView.builder(
                        itemCount: productsInModal.length,
                        itemBuilder: (context, index) {
                          final product = productsInModal[index];

                          final productId = product.id;
                          final quantity =
                              selectedQuantitiesInModal[productId] ?? 0;

                          if (productId == null) {
                            return SizedBox(width: 8);
                          }

                          return ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.storefront_outlined),
                            ),
                            title: Text(product.name),
                            subtitle: Text('Preço: ${product.salePrice}'),
                            trailing: quantity < 1
                                ? ElevatedButton(
                                    onPressed: () {
                                      setModalState(
                                        () =>
                                            selectedQuantitiesInModal[productId] =
                                                quantity + 1,
                                      );
                                    },
                                    child: Text('Adicionar'),
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setModalState(() {
                                            if (quantity <= 1) {
                                              selectedQuantitiesInModal.remove(
                                                productId,
                                              );
                                            } else {
                                              selectedQuantitiesInModal[productId] =
                                                  quantity - 1;
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.remove),
                                      ),

                                      Text('$quantity'),

                                      IconButton(
                                        onPressed: () {
                                          setModalState(() {
                                            selectedQuantitiesInModal[productId] =
                                                quantity + 1;
                                          });
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                            onTap: () {},
                          );
                        },
                      );
                    },
                  ),
                ),
                if (selectedQuantitiesInModal.isNotEmpty)
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsetsGeometry.fromLTRB(16, 8, 16, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () =>
                              Navigator.pop(context, selectedQuantitiesInModal),
                          child: Text(
                            'Concluir• ${selectedQuantitiesInModal.length}',
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

  final productsCompleteList = productController.products;

  context.read<OrderDetailsController>().selectProducts(
    productsCompleteList: productsCompleteList,
    quantities: selectedQuantitiesMap,
  );
}
