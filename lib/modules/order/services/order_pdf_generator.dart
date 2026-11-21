import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/formatters/display_formatters.dart';
import '../../../entities/order/order_edit_data.dart';
import '../../../entities/order/payment_type.dart';
import '../../../entities/profile.dart';

class OrderPdfGenerator {
  Future<Uint8List> generate(
    OrderEditData orderData,
    Profile profile,
    int primaryColorArgb,
  ) async {
    final primaryColor = PdfColor.fromInt(primaryColorArgb);
    final order = orderData.order;
    final carrier = orderData.carrier;
    final customer = orderData.customer;

    final productsSubtotal = order.items.fold<double>(
      0,
      (total, item) => total + item.subtotal,
    );
    final discountsTotal = order.items.fold<double>(
      0,
      (total, item) => total + item.discountAmount,
    );
    final orderTotal = productsSubtotal - discountsTotal + order.freight;
    final installments = order.paymentItem.installments;
    final installmentValue = installments > 1
        ? orderTotal / installments
        : orderTotal;
    final paymentLabel = switch (order.paymentItem.paymentType) {
      PaymentType.creditCard => 'Cartão de crédito',
      PaymentType.cash => 'Dinheiro',
      PaymentType.bankTransfer => 'Transferência bancária',
      PaymentType.pix => 'Pix',
    };
    final paymentDescription = installments > 1
        ? '$paymentLabel em ${installments}x de ${DisplayFormatters.formatMoney(installmentValue)}'
        : paymentLabel;
    final paymentNotes = order.paymentNotes?.trim() ?? '';

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
              horizontal: 40,
              vertical: 30,
            ),
            decoration: const pw.BoxDecoration(color: PdfColors.blue900),
            child: pw.Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .end,
              children: [
                pw.Column(
                  crossAxisAlignment: .start,
                  children: [
                    pw.Container(
                      width: 80,
                      height: 80,
                      alignment: pw.Alignment.center,
                      decoration: pw.BoxDecoration(
                        color: primaryColor,
                        borderRadius: pw.BorderRadius.circular(22),
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
                              horizontalRadius: 22,
                              verticalRadius: 22,
                              child: pw.Image(
                                logo,
                                width: 80,
                                height: 80,
                                fit: pw.BoxFit.cover,
                              ),
                            ),
                    ),
                    pw.SizedBox(height: 10),

                    pw.Text(
                      profile.name,
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 18,
                        fontWeight: .bold,
                      ),
                    ),
                    pw.Text(
                      DisplayFormatters.formatCnpj(profile.cnpj),
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 14,
                        fontWeight: .normal,
                      ),
                    ),
                    if (profile.legalName != null)
                      pw.Text(
                        profile.legalName ?? '',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 14,
                          fontWeight: .normal,
                        ),
                      ),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: .end,
                  children: [
                    pw.Text(
                      'PEDIDO',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 14,
                        fontWeight: .normal,
                      ),
                    ),
                    pw.Text(
                      'PED #${order.id}',
                      style: pw.TextStyle(
                        color: primaryColor,
                        fontSize: 40,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'EMITIDO EM: ${DisplayFormatters.formatDate(order.createdAt)}',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 14,
                        fontWeight: .normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 24,
            ),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: _informationCard(
                    title: 'CLIENTE',
                    children: [
                      pw.Text(
                        customer.name,
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'CNPJ ${DisplayFormatters.formatCnpj(customer.cnpj)}',
                      ),
                      if (customer.phoneNumber?.trim().isNotEmpty ?? false)
                        pw.Text(customer.phoneNumber!.trim()),
                      if (customer.email?.trim().isNotEmpty ?? false)
                        pw.Text(customer.email!.trim()),
                    ],
                  ),
                ),
                pw.SizedBox(width: 16),
                pw.Expanded(
                  child: _informationCard(
                    title: 'ENDEREÇO DE ENTREGA',
                    children: [
                      pw.Text(
                        '${customer.street}, ${customer.number}',
                        style: pw.TextStyle(fontSize: 13),
                      ),
                      pw.Text(
                        '${customer.city}/${customer.state} - CEP ${customer.zipCode}',
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text('Transportadora: ${carrier.name}'),
                      pw.Text(
                        'Frete: ${DisplayFormatters.formatMoney(order.freight)}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.ClipRRect(
              horizontalRadius: 8,
              verticalRadius: 8,
              child: pw.TableHelper.fromTextArray(
                headers: ['Produto', 'Qtd.', 'Preço Un.', 'Desc.', 'Total'],
                data: order.items
                    .map(
                      (item) => [
                        item.product.name,
                        item.quantity.toString(),
                        DisplayFormatters.formatMoney(item.unitPrice),
                        item.discountPercent > 0
                            ? '${item.discountPercent}%'
                            : '-',
                        DisplayFormatters.formatMoney(item.total),
                      ],
                    )
                    .toList(),
                cellPadding: const pw.EdgeInsets.all(8),
                headerDecoration: const pw.BoxDecoration(
                  color: PdfColors.blue50,
                ),
                headerStyle: pw.TextStyle(
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                ),
                oddRowDecoration: const pw.BoxDecoration(
                  color: PdfColors.grey100,
                ),
                border: pw.TableBorder.all(
                  color: PdfColors.grey300,
                  width: 0.5,
                ),
                cellAlignment: pw.Alignment.center,
                cellAlignments: {0: pw.Alignment.centerLeft},
              ),
            ),
          ),

          pw.SizedBox(height: 20),

          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 32),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: _informationCard(
                    title: 'PAGAMENTO',
                    children: [
                      pw.Text(
                        paymentDescription,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                      if (paymentNotes.isNotEmpty)...[
                        pw.Text(paymentNotes),
                      ] ,
                    ],
                  ),
                ),
                pw.SizedBox(width: 16),
                pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.blueGrey50,
                      borderRadius: pw.BorderRadius.circular(16),
                    ),
                    child: pw.Column(
                      children: [
                        _summaryRow(
                          'Subtotal dos produtos',
                          DisplayFormatters.formatMoney(productsSubtotal),
                        ),
                        _summaryRow(
                          'Descontos',
                          '- ${DisplayFormatters.formatMoney(discountsTotal)}',
                        ),
                        _summaryRow(
                          'Entrega',
                          DisplayFormatters.formatMoney(order.freight),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: pw.BoxDecoration(
                            color: primaryColor,
                            borderRadius: const pw.BorderRadius.only(
                              bottomLeft: pw.Radius.circular(16),
                              bottomRight: pw.Radius.circular(16),
                            ),
                          ),
                          child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Total',
                                style: pw.TextStyle(color: PdfColors.white),
                              ),
                              pw.Text(
                                DisplayFormatters.formatMoney(orderTotal),
                                style: pw.TextStyle(
                                  color: primaryColor,
                                  fontSize: 24,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return pdf.save();
  }

  pw.Widget _informationCard({
    required String title,
    required List<pw.Widget> children,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColors.blueGrey50,
        borderRadius: pw.BorderRadius.circular(16),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              color: PdfColors.blueGrey700,
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  pw.Widget _summaryRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(child: pw.Text(label)),
          pw.SizedBox(width: 8),
          pw.Text(value),
        ],
      ),
    );
  }
}
