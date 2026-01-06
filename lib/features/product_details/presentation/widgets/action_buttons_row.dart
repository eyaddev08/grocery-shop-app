import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../cart/domain/entities/cart_item.dart' as cart_entity;
import '../../../../core/constants/app_colors.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../../products/domain/entities/product_entity.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key, required this.details});
  final ProductEntity details;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          children: [
            SizedBox(
              width: 143,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  final cubit = context.read<CartCubit>();
                  final item = cart_entity.CartItem(
                      id: details.id,
                      title: details.name,
                      price: details.price,
                      regularPrice: details.originalPrice,
                      quantity: details.minOrderQty,
                      image: details.thumbnail);
                  cubit.addItem(item);
                  showCustomSnackBarWidget(
                      'The product has been successfully added to your basket!',
                      context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: kPrimaryBlue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  'Add To Cart',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: kPrimaryBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
