import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';

class ProductListHeader extends StatelessWidget {
  final VoidCallback onSortTap;
  final VoidCallback onFilterTap;

  const ProductListHeader({
    super.key,
    required this.onSortTap,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Text(
              'Product List',
              style: textBold.copyWith(
                fontSize: 18,
                color: kPrimaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            _buildIconButton(
              icon: Icons.sort,
              onTap: onSortTap,
            ),
            const SizedBox(width: 8),
            _buildIconButton(
              icon: Icons.tune,
              onTap: onFilterTap,
            ),
          ],
        ),
      );

  Widget _buildIconButton(
          {required IconData icon, required VoidCallback onTap}) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: kPrimaryBlue),
        ),
      );
}
