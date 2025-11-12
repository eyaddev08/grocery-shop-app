import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.active,
      required this.activeColor,
      required this.inactiveColor,
      required this.onTap,
      required this.scale});
  final String icon;
  final String label;
  final bool active;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final color = active ? activeColor : inactiveColor;
    return InkWell(
      onTap: onTap,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 44 * scale,
          height: 44 * scale,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            icon,
            width: 22 * scale,
            height: 22 * scale,
            color: Colors.grey[700],
            placeholderBuilder: (___) => Container(color: Colors.grey.shade300),
          ),
        ),
        SizedBox(height: 6 * scale),
        Text(label,
            style: TextStyle(
                color: color,
                fontSize: 12 * scale,
                fontWeight: FontWeight.w500))
      ]),
    );
  }
}
