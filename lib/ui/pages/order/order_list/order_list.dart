import 'package:flutter/material.dart';

import '../../../../entities/order/order.dart';
import '../../../../entities/order/order_item.dart';
import '../../../../entities/order/payment_type.dart';
import '../../../../entities/product.dart';
import '../order_details.dart';
import 'order_list_card.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100,),
        OrderListCard(
          order: Order(
            id: 42,
            customerId: 1,
            carrierId: 1,
            paymentItem: PaymenItem(
              paymentType: PaymentType.creditCard,
              installments: 3,
            ),
            freight: 120,
            createdAt: DateTime.now().toIso8601String(),
            items: [
              OrderItem(
                id: 1,
                order_id: 42,
                product: Product(
                  id: 1,
                  name: 'Colchonete 100 cm',
                  barcode: '7891234567890',
                  brand: 'Vigor',
                  salePrice: 48.90,
                ),
                quantity: 2,
                unitPrice: 48.90,
              ),
              OrderItem(
                id: 2,
                order_id: 42,
                product: Product(
                  id: 2,
                  name: 'Tapete para exercício',
                  barcode: '7899876543210',
                  brand: 'Lince',
                  salePrice: 35.50,
                ),
                quantity: 1,
                unitPrice: 35.50,
                discountPercent: 10,
              ),
            ],
          ),
          customerName: 'Mercado Santa Tereza',
          orderTotal: 259.74,
          onTap: () => debugPrint('Pedido 42 selecionado'),
        ),
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderDetailsPage()),
            ),
            child: Text('Details'),
          ),
        ),
      ],
    );
  }
}
