import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/constants/app_colors.dart';

class TrackMapWidget extends StatelessWidget {
  const TrackMapWidget({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 436,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: ShapeDecoration(
            color: kSoftBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SvgPicture.asset(
              Images.mapImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
