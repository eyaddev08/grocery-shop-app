import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
        decoration: const BoxDecoration(
          color: kPrimaryBlue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 77,
            ),
            Text(
              'Shop',
              style: textRegular.copyWith(
                color: kLightGrayBg,
                fontSize: 50,
              ),
            ),
            Text(
              'By Category',
              style: titilliumBold.copyWith(
                color: kLightGrayBg,
                fontSize: 50,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      );
}
