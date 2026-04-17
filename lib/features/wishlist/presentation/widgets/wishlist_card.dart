import 'package:flutter/material.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helpers/create_slide_fade_route.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/custom_asset_image_widget.dart';
import '../../../../core/widgets/custom_image_widget.dart';
import '../../../../core/widgets/custom_like_button_widget.dart';
import '../../../product_details/presentation/screens/product_details_screen.dart';
import '../../domain/entities/wishlist_product_entity.dart';

typedef OnProductAction = void Function(String productId);

class WishlistCard extends StatelessWidget {
  const WishlistCard({
    super.key,
    required this.wishlistProduct,
    required this.onRemove,
    required this.onAddToCart,
  });

  final WishlistProductEntity wishlistProduct;
  final OnProductAction onRemove;
  final OnProductAction onAddToCart;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.push<void>(
          context,
          createSlideFadeRoute(
            ProductDetailsScreen(productId: wishlistProduct.id),
          ),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 104,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FA),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 0,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 76,
                  height: 76,
                  child: CustomImageWidget(
                    image: wishlistProduct.thumbnail,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      wishlistProduct.name,
                      style: textBold.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPriceSection(),
                        _buildActionButtons(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildPriceSection() => Row(
        children: [
          Text(
            '\$${wishlistProduct.price.toStringAsFixed(2)}',
            style: textBold,
          ),
          const SizedBox(width: 8),
          if (wishlistProduct.originalPrice != null)
            Text(
              '\$${wishlistProduct.originalPrice!.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Color(0xFF5E596E),
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
              ),
            ),
        ],
      );

  Widget _buildActionButtons() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => onAddToCart(wishlistProduct.id),
            child: Container(
              width: 32,
              height: 32,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const CustomAssetImageWidget(Images.addIcon,
                  color: kAccentYellow),
            ),
          ),
          const SizedBox(width: 12),
          CustomLikeButtonWidget(
            isLiked: wishlistProduct.isFavorite,
            onTap: (isCurrentlyLiked) async {
              onRemove(wishlistProduct.id);
              return isCurrentlyLiked;
            },
          ),
        ],
      );
}
