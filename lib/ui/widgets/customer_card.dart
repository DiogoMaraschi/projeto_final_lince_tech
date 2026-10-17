import 'package:flutter/material.dart';

import '../../entities/costumer.dart';

class CustomerCard extends StatelessWidget {
  CustomerCard({super.key, required this.customer, required this.onTap});

  Customer customer;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
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
              Text(
                'CNPJ: ${customer.cnpj}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Text(
                'Contato: ${customer.phoneNumber}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: onTap, icon: const Icon(Icons.chevron_right)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white),
                  color: Colors.purple.shade50,
                ),
                padding: EdgeInsets.only(left: 7, right: 7, top: 2, bottom: 2),
                child: Text(
                  customer.establishmentType.translate(context),
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
