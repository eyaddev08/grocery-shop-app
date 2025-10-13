import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {

  const BottomNavItem(
      {super.key, required this.icon,
      required this.label,
      required this.active,
      required this.activeColor,
      required this.inactiveColor,
      required this.onTap,
      required this.scale});
  final IconData icon;
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
            child: Icon(icon, color: color, size: 20 * scale)),
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

