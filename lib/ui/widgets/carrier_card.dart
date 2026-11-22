import 'package:flutter/material.dart';

import '../../core/formatters/display_formatters.dart';
import '../../entities/carrier.dart';
import '../../l10n/app_localizations.dart';
import '../app_theme.dart';
import '../formatters/input_formatters.dart';

class CarrierCard extends StatelessWidget {
  const CarrierCard({super.key, required this.carrier, required this._onTap});

  final Carrier carrier;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: SizedBox(
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    carrier.name,
                    style: TextStyle(fontSize: 20, fontWeight: .w500),
                  ),
                  Text(
                    'CNPJ: ${DisplayFormatters.formatCnpj(carrier.cnpj)}',
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.carrierCostPerKm,
                          ),
                          Text(
                            DisplayFormatters.formatMoney(carrier.costPerKm),
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: .w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 60),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.carrierMinimumPrice,
                          ),
                          Text(
                            DisplayFormatters.formatMoney(carrier.minimumPrice),
                            style: TextStyle(fontWeight: .w400, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              //ARROW
              IconButton(
                onPressed: _onTap,
                icon: const Icon(
                  Icons.chevron_right,
                  size: 28,
                  color: Color(0xFFA1A1AA),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
