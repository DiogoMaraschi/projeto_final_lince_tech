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

                    return CarrierCard(
                      carrier: carrier,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarrierDetailsPage(),
                          ),
                        );
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
