import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';

class RecommendedCard extends StatelessWidget {

  const RecommendedCard(
      {super.key, required this.width,
      required this.name,
      required this.tag,
      required this.unit,
      required this.scale});
  final double width;
  final String name;
  final String tag;
  final String unit;
  final double scale;

  @override
  Widget build(BuildContext context) => Container(
      width: width,
      // height: 94 * scale,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12 * scale),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 4)),
          ]),
      padding: EdgeInsets.all(10 * scale),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 64 * scale,
          width: width,
          decoration: BoxDecoration(
              color: const Color(0xFFF2F5F8),
              borderRadius: BorderRadius.circular(8 * scale)),
          child: Icon(Icons.image,
              size: 28 * scale, color: const Color(0xFF9CA3AF)),
        ),
        SizedBox(height: 8 * scale),
        Text(name,
            style: TextStyle(
                fontSize: 13 * scale,
                fontWeight: FontWeight.w600,
                color: textDark)),
        SizedBox(height: 4 * scale),
        Row(children: [
          Text(tag, style: TextStyle(fontSize: 11 * scale, color: muted)),
          const Spacer(),
          Container(
            width: 26 * scale,
            height: 26 * scale,
            decoration: BoxDecoration(
                color: smallBlue,
                borderRadius: BorderRadius.circular(13 * scale)),
            child: Icon(Icons.add, color: Colors.white, size: 16 * scale),
          ),
        ]),
        SizedBox(height: 6 * scale),
        Text(unit, style: TextStyle(fontSize: 11 * scale, color: muted)),
      ]),
    );
}
