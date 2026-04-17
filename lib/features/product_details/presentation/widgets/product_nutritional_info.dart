import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';
import '../../../../core/constants/app_colors.dart';

class ProductNutritionalInfo extends StatelessWidget {
  const ProductNutritionalInfo({super.key, required this.nutrition});

  final Map<String, String> nutrition;

  @override
  Widget build(BuildContext context) {
    if (nutrition.isEmpty) return const SizedBox.shrink();

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24),
        title: Text('Nutritional facts',
            style: textBold.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: kPrimaryBlue,
            )),
        trailing: const Icon(Icons.keyboard_arrow_down, color: kMutedGray),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 30,
                runSpacing: 10,
                children: nutrition.entries
                    .map((entry) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: kSoftBg,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(4, 4),
                              ),
                            ],
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: textBold.copyWith(
                                  fontSize: 13, color: Colors.black87),
                              children: [
                                TextSpan(
                                  text: '${entry.key}: ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryBlue),
                                ),
                                TextSpan(text: entry.value),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
