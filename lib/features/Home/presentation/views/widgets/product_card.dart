import 'package:flutter/material.dart';

/// Single product tile widget
class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.title,
      required this.badgeColor});
  final String price;
  final String title;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 4)),
          ]),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // image placeholder area
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFFF2F5F8),
                  borderRadius: BorderRadius.circular(12)),
              child: const Center(
                  child: Icon(Icons.image, size: 48, color: Color(0xFF9CA3AF))),
            ),
          ),

          const SizedBox(height: 10),

          // price and add button
          Row(
            children: [
              Text(price,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E222B))),
              const Spacer(),
              InkWell(
                onTap: () => ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Added $title'))),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x29000000),
                            blurRadius: 6,
                            offset: Offset(0, 3)),
                      ]),
                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                ),
              )
            ],
          ),

          const SizedBox(height: 6),

          Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xFF61697C)))),
        ],
      ),
    );
}
