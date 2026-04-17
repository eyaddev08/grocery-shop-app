import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../products/domain/entities/product_entity.dart';

class ProductPriceRow extends StatelessWidget {
  const ProductPriceRow({super.key, required this.details});
  final ProductEntity details;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$${details.price}',
                    style: robotoBold.copyWith(
                      fontSize: 16,
                      color: kPrimaryBlue,
                    ),
                  ),
                  TextSpan(
                    text: '/KG',
                    style: textBold.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: kPrimaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            if (details.discount != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: kPrimaryBlue,
                  borderRadius: BorderRadius.circular(70),
                ),
                child: Text(
                  '\$${details.discount} OFF',
                  style: textBold.copyWith(
                    color: const Color(0xFFFAFAFC),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            const Spacer(),
            if (details.originalPrice != null)
              Opacity(
                  opacity: 0.6,
                  child: Text(
                    '\$Reg: ${details.originalPrice!.toStringAsFixed(2)} USD',
                    style: textBold.copyWith(
                      fontWeight: FontWeight.w400,
                      color: kMuted,
                    ),
                  ))
          ],
        ),
      );
}
