import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../entities/order/order_summary.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../formatters/app_formatters.dart';

class OrderListCard extends StatelessWidget {
  const OrderListCard({
    super.key,
    required this.orderSummary,
    required this.onTap,
    required this.onGeneratePdf,
  });

  final OrderSummary orderSummary;
  final VoidCallback onTap;
  final VoidCallback onGeneratePdf;

  String get formattedDate {
    final date = DateTime.tryParse(orderSummary.created_at);
    if (date == null) return orderSummary.created_at;

    return DateFormat('dd/MM/yyyy · HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF3F7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              color: Color(0xFF4F46E5),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.orderNumber((orderSummary.id ?? '—').toString()),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF18181B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppFormatters.formatMoney(orderSummary.total),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF18181B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  orderSummary.customerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF52525B),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${orderSummary.productsCount == 1 ? l10n.orderProductsCountSingular(orderSummary.productsCount.toString()) : l10n.orderProductsCountPlural(orderSummary.productsCount.toString())} · $formattedDate',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF71717A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${orderSummary.paymentItem.paymentType.translate(context)}'
                      '${orderSummary.paymentItem.installments > 1 ? ' · ${orderSummary.paymentItem.installments}x' : ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF4F46E5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Gerar PDF',
            onPressed: onGeneratePdf,
            icon: const Icon(
              Icons.picture_as_pdf_outlined,
              color: Color(0xFF4F46E5),
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.chevron_right,
              size: 28,
              color: Color(0xFFA1A1AA),
            ),
          ),
        ],
      ),
    );
  }
}