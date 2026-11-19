import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import '../../../entities/order/order_edit_data.dart';

class OrderPdfGenerator {
  Future<Uint8List> generate(OrderEditData data) async {
    final order = data.order;

    final productsTotal = order.items.fold<double>(
      0,
      (total, item) => total + item.total,
    );

    final orderTotal = productsTotal + order.freight;

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text('Pedido #${order.id ?? "Novo"}'),
          pw.SizedBox(height: 12),
          pw.Text('Cliente: ${data.customer.name}'),
          pw.Text('Transportadora: ${data.carrier.name}'),
          pw.SizedBox(height: 20),
          pw.Text('Produtos'),
          pw.Divider(),
          ...order.items.map(
            (item) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Text(
                '${item.quantity} x ${item.product.name}'
                ' - R\$ ${item.total.toStringAsFixed(2)}',
              ),
            ),
          ),
          pw.Divider(),
          pw.Text('Frete: R\$ ${order.freight.toStringAsFixed(2)}'),
          pw.Text('Total: R\$ ${orderTotal.toStringAsFixed(2)}'),
        ],
      ),
    );

    return pdf.save();
  }
}
