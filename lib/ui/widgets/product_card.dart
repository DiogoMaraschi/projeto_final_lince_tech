import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/formatters/display_formatters.dart';
import '../../entities/product.dart';
import '../../l10n/app_localizations.dart';
import '../formatters/input_formatters.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this._product, required this.onTap});

  final Product _product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: SizedBox(
        height: 110,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //PRODUCT IMAGE
              Container(
                width: 74,
                height: 74,
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
                        color: colors.onSurface,
                      ),
                    ),

                    const SizedBox(height: 4),

                    //BRAND
                    Text(
                      _product.brand,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 6),

                    //BARCODE
                    Text(
                      l10n.productEAN(_product.barcode),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.primary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    //SALE PRICE
                    Text(
                      DisplayFormatters.formatMoney(_product.salePrice),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: colors.onSurface,
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
        ),
      ),
    );
  }
}
