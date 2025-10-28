import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ProductNutritionalInfo extends StatelessWidget {
  const ProductNutritionalInfo({super.key, required this.nutrition});
  final List<String> nutrition;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 24),
            collapsedBackgroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: const Text(
              'Nutritional facts',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: kTextDark,
              ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_down, color: kMutedGray),
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: nutrition
                    .map((l) => Chip(
                        backgroundColor: kPrimaryBlue,
                        side: BorderSide.none,
                        label: Text(
                          l,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: kSoftBg,
                          ),
                        )))
                    .toList(),
              ),
              // Container(
              //   width: double.infinity,
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              //   child: const  Text(
              //                  'Calories: 200 • Protein: 12g • Fat: 7g • Carbs: 22g',
              //     style:  TextStyle(
              //       fontFamily: 'Poppins',
              //       fontSize: 14,
              //       color: kTextGray,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
}
