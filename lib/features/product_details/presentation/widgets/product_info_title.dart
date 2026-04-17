import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';
import '../../../../core/widgets/custom_like_button_widget.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../products/domain/entities/product_entity.dart';
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
            _buildLikeButton(),
          ],
        ),
      ),
    );

  Widget _buildLikeButton() => BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        bool isFavorite = isLiked;
        if (state is WishlistLoaded) {
          isFavorite = state.items.any((p) => p.id == product.id);
        }

        return CustomLikeButtonWidget(
          isLiked: isFavorite,
          onTap: (currentIsLiked) => _handleLikeStatus(context, currentIsLiked),
        );
      },
    );

  Future<bool> _handleLikeStatus(BuildContext context, bool currentIsLiked) async {
    final wishlistCubit = context.read<WishlistCubit>();
    
    try {
      if (currentIsLiked) {
        await wishlistCubit.remove(product.id);
        return false;
      } else {
        await wishlistCubit.add(product.toWishlistProduct());

        if (!context.mounted) return true;

        showCustomSnackBarWidget(
          'The product has been added to favorites successfully',
          isError: false,
          context,
          isToaster: true,
        );
        return true;
      }
    } catch (e) {
      return currentIsLiked;
    }
  }
}