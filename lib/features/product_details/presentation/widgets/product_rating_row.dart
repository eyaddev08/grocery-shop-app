import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

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
            const Text(
              '110 Reviews',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFFA0A0AB),
              ),
            ),
          ],
        ),
      );
}
