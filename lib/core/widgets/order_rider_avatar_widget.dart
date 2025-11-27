import 'package:flutter/material.dart';

class OrderRiderAvatar extends StatelessWidget {
  const OrderRiderAvatar({
    super.key,
    this.size = 39,
    this.iconSize = 20,
  });

  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) => Container(
      width: size,
      height: size,
      decoration: const ShapeDecoration(
        color: Color(0xFFECECEC),
        shape: OvalBorder(
          side: BorderSide(
            width: 3,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Colors.white,
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F043417),
            blurRadius: 50,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Icon(
        Icons.person,
        size: iconSize,
        color: Colors.grey.shade600,
      ),
    );
}
