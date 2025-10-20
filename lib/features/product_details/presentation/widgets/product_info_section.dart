import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.desc});
   final String desc;
  @override
  Widget build(BuildContext context) =>  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Details',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: kPrimaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 327,
            child: Text(
             desc,  // 'Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Nullam quis risus eget urna mollis ornare vel eu leo.',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: kTextGray,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
}
