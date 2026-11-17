import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

import 'carrier_list.dart';
import 'costumer_list.dart';
import 'order/order_details.dart';
import 'order/order_list/order_list.dart';
import 'product_list.dart';
import 'profile.dart';
import 'profile_details.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPage();
}

class _MainNavigationPage extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ProductListPage(),
    OrderListPage(),
    CarrierListPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home_outlined),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt),
            selectedIcon: Icon(Icons.receipt_outlined),
            label: l10n.navOrders,
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2),
            selectedIcon: Icon(Icons.inventory_2_outlined),
            label: l10n.navRecords,
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront),
            selectedIcon: Icon(Icons.storefront_outlined),
            label: l10n.navStore,
          ),
        ],
      ),
    );
  }
}
