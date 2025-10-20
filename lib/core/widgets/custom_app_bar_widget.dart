import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    super.key,
    this.label = 'Hey, Halal',
    this.backgroundColor = deepBlue,
    this.titleSpacing = 18,
    this.centerTitle = false,
    this.labelSize = 22,
    this.automaticallyImplyLeading = false,
    this.labelColor = Colors.white,
  });
  final String label;
  final Color backgroundColor;
  final int titleSpacing;
  final int labelSize;
  final Color labelColor;
  final bool centerTitle;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    final double scale = s(context);
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E222B)),
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        titleSpacing: 18,
        excludeHeaderSemantics: true,
        clipBehavior: Clip.none,
        title: Text(label,
            style: TextStyle(
                color: labelColor,
                fontSize: labelSize * scale,
                fontWeight: FontWeight.w600)),
        actions: [
          SvgPicture.asset('assets/svg/search_icon.svg',
              color: labelColor, height: 22 * scale),
          const SizedBox(width: 12),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/svg/bag_icon.svg',
                  height: 22,
                  color: labelColor,
                ),
              ),
              Positioned(
                right: 8 * scale,
                top: 6 * scale,
                child: Container(
                    width: 22 * scale,
                    height: 22 * scale,
                    decoration: BoxDecoration(
                        color: yellow,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.white, width: 2 * scale)),
                    child: Center(
                        child: Text('3',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12 * scale,
                                fontWeight: FontWeight.w600,
                                height: 1)))),
              )
            ],
          ),
        ],
      ),
    );
  }
}
