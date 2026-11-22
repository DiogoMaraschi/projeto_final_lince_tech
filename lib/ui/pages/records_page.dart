import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'carrier_list.dart';
import 'costumer_list.dart';
import 'product_list.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.navRecords),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: l10n.productListTitle),
              Tab(text: l10n.customerListTitle),
              Tab(text: l10n.carrierListTitle),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProductListPage(),
            CustomerListPage(),
            CarrierListPage(),
          ],
        ),
      ),
    );
  }
}