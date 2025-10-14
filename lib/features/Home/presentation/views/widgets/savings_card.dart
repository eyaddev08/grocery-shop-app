import 'package:flutter/material.dart';

class SavingsCard extends StatelessWidget {
  const SavingsCard(
      {super.key, required this.background,
      required this.number,
      required this.unit,
      required this.label});
  final Color background;
  final String number;
  final String unit;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
      height: 123,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 3))
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '$number ',
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E222B))),
                  TextSpan(
                      text: unit,
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1E222B))),
                ],
               
              ),
            ),
            const SizedBox(height: 8),
            Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1E222B))),
          ]),
    );
}


