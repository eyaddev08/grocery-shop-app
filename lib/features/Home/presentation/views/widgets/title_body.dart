import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';

class TitleBody extends StatelessWidget {
  const TitleBody({
    super.key,
    required this.scale,
    this.onTap, required this.title,
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
            style: TextStyle(
                fontSize: 18 * scale,
                fontWeight: FontWeight.w600,
                color: textDark)),
        InkWell(
            onTap: onTap,
            child: const Text('View all',
                style: TextStyle(
                    color: Color(0xFF5E596E),
                    fontSize: 12,
                    fontWeight: FontWeight.w500)))
      ]));
}
