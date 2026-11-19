import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class OrderPdfPreview extends StatelessWidget {
  const OrderPdfPreview({super.key, required this.pdfBytes});

  final Uint8List pdfBytes;

  Future<void> _sharePdf() {
    return SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            pdfBytes,
            mimeType: 'application/pdf',
            name: 'pedido.pdf',
          ),
        ],
        fileNameOverrides: ['pedido.pdf'],
        subject: 'Pedido',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Pedido')),
      body: PdfPreview(
        build: (_) async => pdfBytes,
        allowSharing: false,
        allowPrinting: true,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        actionBarTheme: PdfActionBarTheme(
          backgroundColor: primaryColor,
          height: 70,
          alignment: .center
        ),
        actions: [
          IconButton(
            onPressed: _sharePdf,
            icon: Icon(Icons.share),
            tooltip: 'Compartilhar PDF',
          ),
        ],
      ),
    );
  }
}
