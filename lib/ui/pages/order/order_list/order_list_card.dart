import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/formatters/display_formatters.dart';
import '../../../../entities/order/order_summary.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../formatters/input_formatters.dart';

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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.orderNumber((orderSummary.id).toString()),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DisplayFormatters.formatMoney(orderSummary.total),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
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
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    '${orderSummary.productsCount == 1 ? l10n.orderProductsCountSingular(orderSummary.productsCount.toString()) : l10n.orderProductsCountPlural(orderSummary.productsCount.toString())} · ${DisplayFormatters.formatDate(orderSummary.created_at)}',
                    style: const TextStyle(
                      fontSize: 12,
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
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Gerar PDF',
              onPressed: onGeneratePdf,
              icon:  Icon(
                Icons.picture_as_pdf_outlined,
                color: colors.primary,
              ),
            ),
            IconButton(
              onPressed: onTap,
              icon: const Icon(
                Icons.chevron_right,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
