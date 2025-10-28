import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/utils/dimensions.dart';

import '../../../../core/constants/app_colors.dart';


class CartSummarySection extends StatelessWidget {
  const CartSummarySection({
    super.key,
    required this.subtotal,
    required this.delivery,
    required this.total,
   required this.button,
  });

  final double subtotal;
  final double delivery;
  final double total;
  final Widget button;


  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: kPale,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeTwelve,
            vertical: Dimensions.paddingSizeLarge),
        child: Column(
          children: [
            _priceRow(
                title: 'Subtotal', amount: '\$${subtotal.toStringAsFixed(2)}'),
            const SizedBox(height: 13),
            _priceRow(
                title: 'Delivery', amount: '\$${delivery.toStringAsFixed(2)}'),
            const SizedBox(height: 13),
            _priceRow(
                title: 'Total',
                amount: '\$${total.toStringAsFixed(2)}',
                isTotal: true),
            const SizedBox(height: 35),
           button,
            const SizedBox(height: 8),
          ],
        ),
      );

  Widget _priceRow(
          {required String title,
          required String amount,
          bool isTotal = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF61697C),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ),
            const Spacer(),
            Text(
              amount,
              style: TextStyle(
                color: const Color(0xFF1E222B),
                fontSize: 14,
                fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      );
}
