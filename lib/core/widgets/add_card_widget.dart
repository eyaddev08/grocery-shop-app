import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/presentation/manager/cart_cubit.dart';
import '../../features/cart/domain/entities/cart_item.dart' as cart_entity;

import '../constants/app_colors.dart';
import 'custom_snackbar_widget.dart';

class AddCardWidget extends StatelessWidget {
  const AddCardWidget({
    super.key,
    required this.id,
    this.sizeContainer = 32,
    this.sizeIcon = 18,
    required this.title,
    required this.price,
    this.regularPrice,
    required this.image,
  });
  final double? sizeContainer;
  final double? sizeIcon;
  final String id;
  final String title;
  final double price;
  final double? regularPrice;
  final String image;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              final cubit = context.read<CartCubit>();

              final item = cart_entity.CartItem(
                  id: id,
                  title: title,
                  price: price,
                  regularPrice: regularPrice,
                  quantity: 1,
                  image: image);
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
              child: Image.asset('assets/images/add_icon.png',
                  color: kYellow, height: sizeIcon, width: sizeIcon),
            ),
          ),
        ],
      );
}
