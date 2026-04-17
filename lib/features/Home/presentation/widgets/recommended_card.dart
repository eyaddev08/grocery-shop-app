import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/utils/images.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/add_to_cart_widget.dart';
import '../../../../core/widgets/custom_image_widget.dart';
import '../../../products/domain/entities/product_entity.dart';

class RecommendedCard extends StatelessWidget {
  const RecommendedCard(
      {super.key,
      required this.width,
      required this.scale,
      required this.product});
  final ProductEntity product;
  final double width;

  final double scale;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 8 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(12 * scale),
        ),
        padding: EdgeInsets.all(10 * scale),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 10 * scale),
          Container(
            height: 54 * scale,
            width: width,
            decoration: BoxDecoration(
                // color: const Color(0xFFF2F5F8),
                borderRadius: BorderRadius.circular(8 * scale)),
            child: CustomImageWidget(
                image: product.thumbnail ?? Images.emptyImage,
                fit: BoxFit.contain),
          ),
          SizedBox(height: 20 * scale),
          Divider(
            color: kMuted.withOpacity(0.2),
            thickness: 1.5,
          ),
          SizedBox(height: 12 * scale),
          Text(product.name,
              style: TextStyle(
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.w600,
                  color: kTextDark)),
          Text(product.filterLabel ?? '',
              style: TextStyle(fontSize: 11 * scale, color: kMuted)),
          SizedBox(height: 8 * scale),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12 * scale),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 10,
                      offset: Offset(0, 4)),
                ]),
            child: Row(children: [
              SizedBox(width: 5 * scale),
              RichText(
                text: TextSpan(
                  style: textBold.copyWith(fontSize: 12),
                  children: [
                    TextSpan(
                      text: product.unit ?? '',
                      style: textBold.copyWith(
                          fontSize: 11 * scale, color: kMuted),
                    ),
                    TextSpan(text: ' \$${product.price}'),
                  ],
                ),
              ),
              const Spacer(),
              AddToCartWidget(
                 product: product,
                  sizeContainer: 26,
                  sizeIcon: 14),
            ]),
          ),
        ]),
      );
}
