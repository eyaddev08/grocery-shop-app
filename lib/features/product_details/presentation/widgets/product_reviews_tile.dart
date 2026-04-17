import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class ProductReviewsTile extends StatelessWidget {
  const ProductReviewsTile({super.key});

  @override
  Widget build(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child:  ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 24),
      title: Text(
        'Reviews',
         style: textBold.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: kPrimaryBlue,
        ),
      ),
      trailing: const Icon(Icons.keyboard_arrow_down, color: kMutedGray),
      children:  [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '— “Great product, fresh and tasty.”',
                style: textBold.copyWith(
                    color: kTextGray),
              ),
              const SizedBox(height: 8),
               Text(
                '— “Value for money.”',
                style: textBold.copyWith(
                    color: kTextGray),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    ),
  );
}
