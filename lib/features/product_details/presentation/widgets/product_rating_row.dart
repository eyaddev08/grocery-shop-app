import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';


class ProductRatingRow extends StatelessWidget {
  const ProductRatingRow({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          children: [
            Row(
              children: List.generate(
                  5,
                  (index) => const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.star,
                          size: 16,
                          color: kAccentYellow,
                        ),
                      )),
            ),
            const SizedBox(width: 8),
             Text(
              '110 Reviews',
              style: textBold.copyWith(
                fontWeight: FontWeight.w400,
                color: kTextGray,
              ),
            ),
          ],
        ),
      );
}
