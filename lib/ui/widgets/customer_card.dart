import 'package:flutter/material.dart';

import '../../core/formatters/display_formatters.dart';
import '../../entities/customer/costumer.dart';
import '../../l10n/app_localizations.dart';

class CustomerCard extends StatelessWidget {
  CustomerCard({super.key, required this.customer, required this.onTap});

  Customer customer;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 4, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: TextStyle(fontSize: 20, fontWeight: .w500),
                  ),
                  SizedBox(height: 9),
                  Text('CNPJ: ${DisplayFormatters.formatCnpj(customer.cnpj)}'),
                  Text(
                    l10n.commonContact(
                      DisplayFormatters.formatPhone(customer.phoneNumber),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: onTap,
                    icon: const Icon(Icons.chevron_right),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white),
                      color: Colors.purple.shade50,
                    ),
                    padding: EdgeInsets.only(
                      left: 7,
                      right: 7,
                      top: 2,
                      bottom: 2,
                    ),
                    child: Text(
                      customer.establishmentType.translate(context),
                      style: TextStyle(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
