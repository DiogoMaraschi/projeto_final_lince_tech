import 'package:flutter/material.dart';

import 'order_details.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderDetailsPage()),
        ),
        child: Text('Details'),
      ),
    );
  }
}
