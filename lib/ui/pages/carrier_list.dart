import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
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
        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          appBar: AppBar(title: Text(l10n.carrierListTitle)),
          body: state.isLoading
              ? Center(child: CircularProgressIndicator())
              : state.carriers.isNotEmpty
              ? Center(child: Text(l10n.carrierListEmpty))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final carrier = state.carriers[index];
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
