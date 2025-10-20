import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = s(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: kSoftBg,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.chevron_left,
                  size: 18, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: kSoftBg,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/svg/bag_icon.svg',
                        height: 22,
                        color: Colors.black54,
                      ),
                    ),
                    Positioned(
                      right: 0 * scale,
                      top: 3 * scale,
                      child: Container(
                        width: 22 * scale,
                        height: 22 * scale,
                        decoration: BoxDecoration(
                          color: kAccentYellow,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white, width: 2 * scale),
                        ),
                        child: Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
