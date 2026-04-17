import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../features/cart/domain/entities/cart_item_entity.dart';
import '../../../features/cart/presentation/manager/cart_cubit.dart';
import '../../widgets/custom_image_widget.dart';

void showRemovedSnackBar(BuildContext context, CartItemEntity item) {
  final cartCubit = context.read<CartCubit>();
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  HapticFeedback.lightImpact();
  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      content: Material(
        color: kPrimaryBlue.withOpacity(0.95),
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: CustomImageWidget(
                      image: item.thumbnail,
                      fit: BoxFit.contain),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Removed',
                        style: textBold.copyWith(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 2),
                    Text(item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textBold.copyWith(
                          color: Colors.white,
                        )),
                    const SizedBox(height: 6),
                    Text('\$${item.price.toStringAsFixed(2)}',
                        style: textBold.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        )),
                  ],
                ),
              ),
              _SnackActionButton(
                label: 'Undo',
                onTap: () {
                  cartCubit.addItem(item);
                  messenger.hideCurrentSnackBar();
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _SnackActionButton extends StatelessWidget {
  const _SnackActionButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: kAccentYellow,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.undo, size: 18, color: Colors.black),
                const SizedBox(width: 6),
                Text(label,
                    style: textBold.copyWith(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
      );
}
