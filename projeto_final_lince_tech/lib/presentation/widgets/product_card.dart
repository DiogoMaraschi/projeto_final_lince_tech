import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this._product, required this.onTap});

  final Product _product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //PRODUCT IMAGE
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF3F7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: _product.imagePath != null
                ? Image.file(File(_product.imagePath!))
                : Icon(
                    Icons.inventory_2_outlined,
                    size: 36,
                    color: Color(0xFF71717A),
                  ),
          ),

          const SizedBox(width: 16),

          //PRODUCT INFORMATION
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //PRODUCT NAME
                Text(
                  _product.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF18181B),
                  ),
                ),

                const SizedBox(height: 4),

                //BRAND
                Text(
                  _product.brand,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF71717A),
                  ),
                ),

                const SizedBox(height: 6),

                //BARCODE
                Text(
                  'EAN: ${_product.barcode}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4F46E5),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          //ARROW
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
