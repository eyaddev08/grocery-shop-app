import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';

import '../../../../core/widgets/custom_like_button_widget.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../wishlist/domain/entities/wishlist_product.dart';
import '../../../wishlist/presentation/manager/cubit/wishlist_cubit.dart';

class ProductInfoTitle extends StatelessWidget {
  const ProductInfoTitle({
    super.key,
    required this.title,
    required this.isLiked,
    required this.product,
  });
  final String title;
  final bool isLiked;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: titilliumBold.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kTextDark,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              BlocBuilder<WishlistCubit, WishlistState>(
                builder: (context, state) {
                  bool isFavorite = isLiked;
                  if (state is WishlistLoaded) {
                    isFavorite = state.items
                        .any((WishlistProduct p) => p.id == product.id);
                  }
                  return CustomLikeButtonWidget(
                    isLiked: isFavorite,
                    onTap: (currentIsLiked) async {
                      try {
                        final wishlistCubit = context.read<WishlistCubit>();

                        if (currentIsLiked) {
                          // إزالة من قائمة الأمنيات
                          await wishlistCubit.remove(product.id);
                          return false;
                        } else {
                          // إضافة إلى قائمة الأمنيات
                          final wishlistProduct = WishlistProduct(
                              id: product.id,
                              title: product.name,
                              price: product.price,
                              oldPrice: product.originalPrice,
                              subTitle:
                                  product.shortDescription ?? product.name,
                              thumbnail: product.thumbnail,
                              discount: product.discount != null
                                  ? (product.discountType == 'percent'
                                      ? product.discount!
                                      : null)
                                  : null,
                              isFavorite: true,
                              images: product.images,
                              regularPrice: product.price,
                              unit: product.unit,
                              rating: product.rating,
                              minOrderQty: product.minOrderQty,
                              discountType: product.discountType,
                              nutritionLines: product.nutritionLines,
                              categoryIds: product.categoryIds,
                              reviewCount: product.reviewCount,
                              brand: product.brand,
                              shippingCost: product.shippingCost,
                              shortDescription: product.shortDescription,
                              currentStock: product.currentStock,
                              tag: product.tag,
                              slug: '',
                              status: product.status);

                          await wishlistCubit.add(wishlistProduct);
                          showCustomSnackBarWidget(
                              'The product has been added to favorites syccessfully',
                              isError: false,
                              context,
                              isToaster: true);
                          return true;
                        }
                      } catch (e) {
                        return currentIsLiked;
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
}
