import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../cart/domain/entities/cart_item_entity.dart' as cart_entity;
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
                  final item = cart_entity.CartItemEntity(
                       id:  details.id,
                       name: details.name,
                       price: details.price,
                       thumbnail: details.thumbnail ?? '',
                       quantity: 1);
                  cubit.addItem(item);
                  showCustomSnackBarWidget(
                      'The product has been successfully added to your basket!',
                      context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: kPrimaryBlue),
                  foregroundColor: kPrimaryBlue.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  'Add To Cart',
                  style: textBold.copyWith(color: kPrimaryBlue),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    final cubit = context.read<CartCubit>();
                    final item = cart_entity.CartItemEntity(
                       id:  details.id,
                       name: details.name,
                       price: details.price,
                       thumbnail: details.thumbnail ?? '',
                       quantity: 1);
                    cubit.addItem(item);
                    NavigationService.navigateTo(AppRoutes.cart);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    foregroundColor: kSearchBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    'Buy Now',
                    style: textBold.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
