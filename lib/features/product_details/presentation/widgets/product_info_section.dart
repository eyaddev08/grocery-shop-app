import 'package:flutter/material.dart';

import 'package:grocery_shop_app/core/utils/styles.dart';
import '../../../../core/constants/app_colors.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.desc});
  final String desc;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: textBold.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kPrimaryBlue,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 327,
              child: Text(
                desc,
                style: textBold.copyWith(
                  fontWeight: FontWeight.w400,
                  color: kTextGray,
                ),
              ),
            ),
          ],
        ),
      );
}
