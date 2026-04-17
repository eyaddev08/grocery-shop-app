import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/presentation/manager/cart_cubit.dart';
import '../../features/cart/domain/entities/cart_item_entity.dart'
    as cart_entity;

import '../../features/products/domain/entities/product_entity.dart';
import '../constants/app_colors.dart';
import '../utils/images.dart';
import 'custom_asset_image_widget.dart';
import 'custom_snackbar_widget.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
    super.key,
    this.sizeContainer = 32,
    this.sizeIcon = 18,
    required this.product,
  });
  final double? sizeContainer;
  final double? sizeIcon;
  final ProductEntity product;


  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              final cubit = context.read<CartCubit>();

              final item = cart_entity.CartItemEntity(
               id:  product.id,
                       name: product.name,
                       price: product.price,
                       thumbnail: product.thumbnail ?? '',
                       quantity: 1,
                  );
              cubit.addItem(item);

              showCustomSnackBarWidget(
                  'The product has been successfully added to your basket!',
                  context);
            },
            child: Container(
              width: sizeContainer,
              height: sizeContainer,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: CustomAssetImageWidget(Images.addIcon,
                  color: kYellow, height: sizeIcon, width: sizeIcon),
            ),
          ),
        ],
      );
}
