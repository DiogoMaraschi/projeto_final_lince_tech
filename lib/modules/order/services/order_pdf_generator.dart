import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../entities/order/order_edit_data.dart';
import '../../../entities/profile.dart';

class OrderPdfGenerator {
  Future<Uint8List> generate(OrderEditData orderData, Profile profile) async {
    final order = orderData.order;
    final carrier = orderData.carrier;
    final customer = orderData.customer;

    final productsTotal = order.items.fold<double>(
      0,
      (total, item) => total + item.total,
    );

    final orderTotal = productsTotal + order.freight;

    pw.MemoryImage? logo;

    final imagePath = profile.imagePath;

    if (imagePath != null && imagePath.isNotEmpty) {
      final file = File(imagePath);

      if (await file.exists()) {
        logo = pw.MemoryImage(await file.readAsBytes());
      }
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(0),
        build: (context) => [
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 100,
            ),
            decoration: const pw.BoxDecoration(color: PdfColors.blue300),
            child: pw.Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Container(
                      width: 90,
                      height: 90,
                      alignment: pw.Alignment.center,
                      decoration: pw.BoxDecoration(
                        color: PdfColors.deepPurple,
                        borderRadius: pw.BorderRadius.circular(12),
                      ),
                      child: logo == null
                          ? pw.Text(
                              profile.name[0].toUpperCase(),
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 32,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            )
                          : pw.ClipRRect(
                              horizontalRadius: 12,
                              verticalRadius: 12,
                              child: pw.Image(
                                logo,
                                width: 90,
                                height: 90,
                                fit: pw.BoxFit.cover,
                              ),
                            ),
                    ),
                  ],
                ),
                pw.Text(
                  'Pedido #${order.id ?? "Novo"}',
                  style: pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Pedido #${order.id ?? "Novo"}',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 6),
                pw.Text('Cliente: ${customer.name}'),
                pw.Text('Transportadora: ${carrier.name}'),
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          pw.Text(
            'Produtos',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),

          pw.TableHelper.fromTextArray(
            headers: ['Produto', 'Qtd.', 'Total'],
            data: order.items
                .map(
                  (item) => [
                    item.product.name,
                    item.quantity.toString(),
                    'R\$ ${item.total.toStringAsFixed(2)}',
                  ],
                )
                .toList(),
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.blueGrey800,
            ),
            headerStyle: pw.TextStyle(
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
            ),
            oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey100),
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          ),

          pw.SizedBox(height: 20),

          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: PdfColors.blueGrey50,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text('Frete: R\$ ${order.freight.toStringAsFixed(2)}'),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Total: R\$ ${orderTotal.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return pdf.save();
  }
}
