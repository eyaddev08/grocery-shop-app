import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_image_widget.dart';
import '../../domain/entities/category.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key, required this.category, this.onTap});

  final Category category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 167,
            child: Row(
              children: [
                Container(
                  width: 137,
                  height: 167,
                  decoration: ShapeDecoration(
                    color: category.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: CustomImageWidget(
                        image: category.image ?? '', fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 11),
                    Text(
                      category.title,
                      textAlign: TextAlign.center,
                      style: titilliumBold.copyWith(
                        color: const Color(0xFF1E222B),
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      category.subtitle,
                      textAlign: TextAlign.center,
                      style: robotoBold.copyWith(
                        color: const Color(0xFF61697C),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 47),
                    Text(
                      'Starting from',
                      style: textMedium.copyWith(
                        color: const Color(0xFF8791A5),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$${category.price}',
                            style: robotoBold.copyWith(
                              color: kPrimaryBlue,
                              fontSize: 17,
                            ),
                          ),
                          TextSpan(
                            text: '/KG',
                            style: robotoBold.copyWith(
                              color: kPrimaryBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
