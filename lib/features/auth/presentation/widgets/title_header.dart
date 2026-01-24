import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({super.key, required this.title, required this.subTitle});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: titilliumBold.copyWith(
              fontSize: 24,
              color: kLightGrayBg,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: textBold.copyWith(color: kTextGray),
          ),
        ],
      );
}
