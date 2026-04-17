import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';

class ProfileInfoSectionShimmer extends StatelessWidget {
  const ProfileInfoSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(children: [
          Shimmer.fromColors(
            baseColor: kAccentYellow,
            highlightColor: kAccentYellow.withOpacity(0.5),
            child: Stack(alignment: Alignment.bottomRight, children: [
              CircleAvatar(
                  radius: 45, backgroundColor: kAccentYellow.withOpacity(0.8)),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 20,
                  width: 20,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: kAccentYellow.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            width: 120,
            height: 24,
            decoration: BoxDecoration(
              color: kAccentYellow.withOpacity(0.8),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 180,
            height: 16,
            decoration: BoxDecoration(
              color: kAccentYellow.withOpacity(0.8),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ]),
      );
}
