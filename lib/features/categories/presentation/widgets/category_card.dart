import 'package:flutter/material.dart';
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
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 11),
                    Text(
                      category.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF1E222B),
                        fontSize: 18,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w700,
                        height: 1.22,
                      ),
                    ),
                    Text(
                      category.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF61697C),
                        fontSize: 16,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    const SizedBox(height: 47),
                    const Text(
                      'Starting from',
                      style: TextStyle(
                        color: Color(0xFF8791A5),
                        fontSize: 14,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$${category.price}',
                            style: const TextStyle(
                              color: Color(0xFF2A4BA0),
                              fontSize: 16,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w700,
                              height: 1.50,
                            ),
                          ),
                          const TextSpan(
                            text: '/KG',
                            style: TextStyle(
                              color: Color(0xFF2A4BA0),
                              fontSize: 16,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
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
