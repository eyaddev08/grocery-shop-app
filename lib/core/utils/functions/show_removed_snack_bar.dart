import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../features/cart/domain/entities/cart_item.dart';
import '../../../features/cart/presentation/manager/cart_cubit.dart';

void showRemovedSnackBar(BuildContext context, CartItem item) {
  // Capture cubit and messenger here to avoid looking up ancestors from
  // a possibly deactivated context inside the SnackBar action closure.
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
                  child: (item.image ?? '').startsWith('http')
                      ? Image.network(item.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image, color: Colors.white54))
                      : (item.image != null && item.image!.isNotEmpty
                          ? SvgPicture.asset(item.image!, fit: BoxFit.cover)
                          : SvgPicture.asset('assets/svg/empty_image.svg',
                              fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Removed',
                        style: TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'Poppins')),
                    const SizedBox(height: 2),
                    Text(item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            fontSize: 14)),
                    const SizedBox(height: 6),
                    Text('\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13,  fontFamily: 'Poppins')),
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
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
            ],
          ),
        ),
      ),
    );
}
