import 'package:flutter/material.dart';

import 'recommended_card.dart';

class RecommendedListView extends StatelessWidget {
   RecommendedListView({
    super.key,
    required this.scale,
  });

  final double scale;

   final recommended = [
    {'name': 'Fresh Lemon', 'tag': 'Organic', 'unit': r'Unit $12'},
    {'name': 'Green Tea', 'tag': 'Organic', 'unit': r'Unit $06'},
    {'name': 'Fresh Lime', 'tag': 'Organic', 'unit': r'Unit $11'},
    {'name': 'Black Tea', 'tag': 'Organic', 'unit': r'Unit $05'},
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 164 * scale,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: recommended.length,
            separatorBuilder: (_, __) => SizedBox(width: 12 * scale),
            itemBuilder: (context, idx) {
              final item = recommended[idx];
              return RecommendedCard(
                  width: 120 * scale,
                  name: item['name'] as String,
                  tag: item['tag'] as String,
                  unit: item['unit'] as String,
                  scale: scale);
            }));
}
