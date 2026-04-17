import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class TitleBody extends StatelessWidget {
  const TitleBody({
    super.key,
    required this.scale,
    this.onTap,
    required this.title,
  });
  final String title;
  final double scale;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title,
            style: titleRegular.copyWith(
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
                color: kTextDark)),
        InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 10 * scale, vertical: 8 * scale),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Text('View all',
                  style: textBold.copyWith(
                    color: kPrimaryBlue, // const Color(0xFF5E596E),
                    fontSize: 13,
                  )),
            ))
      ]));
}
