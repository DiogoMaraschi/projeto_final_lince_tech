import 'package:flutter/material.dart';

import '../../entities/carrier.dart';
import '../app_colors.dart';

class CarrierCard extends StatelessWidget {
  const CarrierCard({super.key, required this.carrier, required this._onTap});

  final Carrier carrier;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
      ),
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
                'CNPJ: ${carrier.cnpj}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Custo por KM',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        'Rs ${carrier.costPerKm}',
                        style: TextStyle(
                          color: AppColors.primaryColor,
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
                        'PREÇO MINIMO',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Text(
                        'Rs ${carrier.minimumPrice}',
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
    );
  }
}
