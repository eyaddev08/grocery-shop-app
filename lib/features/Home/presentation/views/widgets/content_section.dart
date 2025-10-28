import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import 'animated_hero_banner.dart';

import 'products_list_view.dart';
import 'recommended_list_view.dart';
import 'savings_card.dart';
import 'title_body.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({
    super.key,
    required this.scale,
  });
  final double scale;

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 12 * scale),
        const AnimatedHeroBanner(),
        TitleBody(title: 'Recommended', onTap: () {}, scale: scale),
        SizedBox(height: 12 * scale),
        RecommendedListView(scale: scale),
        SizedBox(height: 32 * scale),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16 * scale, vertical: 12 * scale),
            child: const Row(children: [
              Expanded(
                  child: SavingsCard(
                      background: kYellow,
                      number: '346',
                      unit: 'USD',
                      label: 'Your total savings')),
              SizedBox(width: 12),
              Expanded(
                  child: SavingsCard(
                      background: kBeige,
                      number: '215',
                      unit: 'HRS',
                      label: 'Your time saved'))
            ])),
        const SizedBox(height: 18),
        TitleBody(title: 'Deals on Fruits & Tea', onTap: () {}, scale: scale),
        const SizedBox(height: 12),
        ProductListView(scale: scale),
        const SizedBox(height: 50),
      ]);
}
