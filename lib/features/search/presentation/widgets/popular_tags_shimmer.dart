import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class PopularTagsShimmer extends StatelessWidget {
  const PopularTagsShimmer({super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
      baseColor: kBaseColor,
      highlightColor: kHighlightColor,
      child: Wrap(
        spacing: 8,
        runSpacing: 12,
        children: List.generate(8, (index) => _buildShimmerChip()),
      ),
    );

  Widget _buildShimmerChip() => Container(
      width: 80 + (20.0 * (DateTime.now().microsecond % 3)), // Random width
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7E9F0)),
      ),
    );
}
