import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/styles.dart';

class PromoCard extends StatelessWidget {

  const PromoCard({
    super.key,
    required this.width,
    required this.background,
    required this.title,
    required this.bigText,
    required this.subtitle,
    required this.scale,
    this.imageSrc,
  });
  final double width;
  final Color background;
  final String title;
  final String bigText;
  final String subtitle;
  final double scale;
  final String?
      imageSrc;

  bool _isNetwork(String src) => src.startsWith('http');

  @override
  Widget build(BuildContext context) => Container(
        width: 340,
        height: 170,
        decoration: BoxDecoration(
            color: background, borderRadius: BorderRadius.circular(16 * scale)),
        padding: EdgeInsets.all(14 * scale),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 90 * scale,
            height: 90 * scale,
            decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8 * scale)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8 * scale),
              child: imageSrc != null && imageSrc!.isNotEmpty
                  ? (_isNetwork(imageSrc!)
                      ? Image.network(imageSrc!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image, color: Colors.white54))
                      : SvgPicture.asset(
                          imageSrc!,

                          // fit: BoxFit.cover,
                        ))
                  : const Icon(Icons.image, color: Colors.white54, size: 90),
            ),
          ),
          SizedBox(width: 32 * scale),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  textAlign: TextAlign.start,
                  style: titleRegular.copyWith(
                      color: Colors.white70,
                      fontSize: 20 * scale,
                      fontWeight: FontWeight.w500)),
              Text(bigText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30 * scale,
                      fontWeight: FontWeight.w800)),
              SizedBox(height: 3 * scale),
              Text(subtitle,
                  textAlign: TextAlign.start,
                  style:
                      textBold.copyWith(color: Colors.white70, fontSize: 16 * scale)),
            ],
          )
        ]),
      );
}
