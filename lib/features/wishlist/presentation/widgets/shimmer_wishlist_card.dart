import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ShimmerWishlistCard extends StatefulWidget {
  const ShimmerWishlistCard({super.key});

  @override
  State<ShimmerWishlistCard> createState() => _ShimmerWishlistCardState();
}

class _ShimmerWishlistCardState extends State<ShimmerWishlistCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl;

  @override
  void initState() {
    super.initState();
    _ctl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _ctl,
        builder: (context, _) => Container(
          height: 104,
          decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _shimmerBox(width: 80, height: 80),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _shimmerBox(width: 120, height: 18),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _shimmerBox(width: 65, height: 14),
                        const SizedBox(width: 12),
                        _shimmerBox(width: 45, height: 14),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _shimmerBox(width: 36, height: 36, radius: 18),
              const SizedBox(width: 8),
              _shimmerBox(width: 36, height: 36, radius: 18),
            ],
          ),
        ),
      );

  Widget _shimmerBox(
      {required double width, required double height, double radius = 8}) {
    final shimmer = Color.lerp(kBaseColor, kHighlightColor, _ctl.value)!;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: shimmer, borderRadius: BorderRadius.circular(radius)),
    );
  }
}
