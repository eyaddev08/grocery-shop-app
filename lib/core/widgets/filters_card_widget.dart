import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/styles.dart';

class FiltersCardWidget extends StatelessWidget {
  const FiltersCardWidget({
    super.key,
    required this.filterName,
    required this.active,
    this.onTap,
    this.isLoading = false,
  });
  final String filterName;
  final bool active;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: kBaseColor,
        highlightColor: kHighlightColor,
        child: Container(
          width: 80,
          height: 36,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: kMutedGray),
            ),
          ),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: ShapeDecoration(
          color: active ? kAccentYellow : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: active ? kAccentYellow : kMutedGray,
              )),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              filterName,
              textAlign: TextAlign.center,
              style: textBold.copyWith(
                color: active ? const Color(0xFFFAFAFC) : kMuted,
                height: 1.43,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
