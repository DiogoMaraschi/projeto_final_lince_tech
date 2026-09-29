import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/carrier_list_controller.dart';

class CarrierListPage extends StatelessWidget {
  const CarrierListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarrierListController(),
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
          appBar: AppBar(title: const Text('Produtos')),
          body: state.carriers.isEmpty
              ? const Center(child: Text('Nenhum produto cadastrado'))
              : ListView.builder(
                  itemBuilder: (context, index) {
                    //TODO
                  },
                ),
        );
      },
    );
  }
}
