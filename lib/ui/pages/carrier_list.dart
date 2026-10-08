import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../controllers/carrier_list_controller.dart';
import '../widgets/carrier_card.dart';
import 'carrier_details.dart';

class CarrierListPage extends StatelessWidget {
  const CarrierListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarrierListController(
        getAllCarriersUsecase: injection.getAllCarriersUsecase,
      )..getAllCarriers(),
      child: const _CarrierListPage(),
    );
  }
}

class _CarrierListPage extends StatelessWidget {
  const _CarrierListPage();

  @override
  Widget build(BuildContext context) {
    return Consumer<CarrierListController>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Transportadoras')),
          body: state.isLoading
              ? Center(child: CircularProgressIndicator())
              : state.carriers.isEmpty
              ? const Center(child: Text('Nenhuma transportadora cadastrada'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.carriers.length,
                  itemBuilder: (context, index) {
                    final carrier = state.carriers[index];

                    print('-----page----');
                    print('id ${carrier.id}');
                    print('nome ${carrier.name}');
                    print('id email ${carrier.email}');
                    print('id cnpj ${carrier.cnpj}');
                    print('id mim ${carrier.minimumPrice}');
                    print('id cost ${carrier.costPerKm}');
                    print('id phone ${carrier.phoneNumber}');

                    return CarrierCard(
                      carrier: carrier,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CarrierDetailsPage(carrier: carrier),
                          ),
                        );
                        if (!context.mounted) return;

                        await state.getAllCarriers();
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CarrierDetailsPage()),
              );
              if (!context.mounted) return;

              state.getAllCarriers();
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
