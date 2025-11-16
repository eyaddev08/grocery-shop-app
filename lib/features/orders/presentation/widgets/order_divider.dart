import 'package:flutter/material.dart';

class OrderDivider extends StatelessWidget {
  const OrderDivider({super.key});

  @override
  Widget build(BuildContext context) => Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFE9EAF4),
          ),
        ),
      ),
    );
}
