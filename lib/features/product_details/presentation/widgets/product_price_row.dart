import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
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
            text:  TextSpan(
              children: [
                TextSpan(
                  text:  '\$${details.price}', //r'$34.70',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryBlue,
                  ),
                ),
                const TextSpan(
                  text: '/KG',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: kPrimaryBlue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: kPrimaryBlue,
              borderRadius: BorderRadius.circular(70),
            ),
            child: const Text(
              r'$22.04 OFF',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFFFAFAFC),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Spacer(),
           Text(
        '\$${details.originalPrice}',  //   r'Reg: $56.70 USD',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kMutedGray,
            ),
          ),
        ],
      ),
    );
}
