import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ProductReviewsTile extends StatelessWidget {
  const ProductReviewsTile({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: const ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              'Reviews',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: kTextDark,
              ),
            ),
            trailing: Icon(Icons.keyboard_arrow_down, color: kMutedGray),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '— “Great product, fresh and tasty.”',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: kTextGray),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '— “Value for money.”',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: kTextGray),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
