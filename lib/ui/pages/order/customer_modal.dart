import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/customer_list_controller.dart';
import '../../controllers/order_details_controller.dart';


Future<void> showCustomerModal(BuildContext context) async {
  final colors = Theme.of(context).colorScheme;
  final height = MediaQuery.sizeOf(context).height;

  final customerController = context.read<CustomerListController>();

  final customersFuture = customerController.getAllCustomers();

  final customerId = await showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: colors.surface,
    showDragHandle: true,
    builder: (modalContext) {
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
                      'Selecionar cliente',
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
                  hintText: 'Buscar por nome ou CNPJ',
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
                future: customersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Erro ao carregar clientes'),
                    );
                  }

                  final customers = customerController.customers;

                  if (customers.isEmpty) {
                    return const Center(
                      child: Text('Nenhum cliente cadastrado'),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      final customer = customers[index];

                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.storefront_outlined),
                        ),
                        title: Text(customer.name),
                        subtitle: Text('CNPJ: ${customer.cnpj}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pop(modalContext, customer.id);
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

  if (!context.mounted || customerId == null) return;

  await context.read<OrderDetailsController>().selectCustomer(customerId);
}