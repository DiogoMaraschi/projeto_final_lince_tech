import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../controllers/customer_list_controller.dart';
import '../widgets/customer_card.dart';
import 'costumers_details.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomerListController(
        getAllCustomersUsecase: injection.getAllCustomersUsecase,
      )..getAllCustomers(),
      child: _CostumerListPage(),
    );
  }
}

class _CostumerListPage extends StatelessWidget {
  const _CostumerListPage();

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerListController>(
      builder: (context, state, child) {
        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          appBar: AppBar(title: Text(l10n.customerListTitle)),
          body: state.isLoading
              ? Center(child: CircularProgressIndicator())
              : state.customers.isEmpty
              ? Center(child: Text(l10n.customerListEmpty))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.customers.length,
                  itemBuilder: (context, index) {
                    final customer = state.customers[index];
                    return CustomerCard(
                      customer: customer,
                      onTap: () async{
                       await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CustomerDetailsPage(customer: customer),
                          ),
                        );
                       if (!context.mounted) return;

                       await state.getAllCustomers();
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerDetailsPage()),
              );
              if (!context.mounted) return;

              state.getAllCustomers();
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
