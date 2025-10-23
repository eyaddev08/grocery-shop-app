import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/cart_item.dart';
import 'counter_cart.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(children: [
            const SizedBox(width: 12),
            SizedBox(
              width: 56,
              height: 56,
              child: (item.image ?? '').isNotEmpty
                  ? SvgPicture.asset(item.image!)
                  : SvgPicture.asset('assets/svg/empty_image.svg'),
            ),

            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                        color: textDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text('\$${item.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: textDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(width: 8),
                      if (item.regularPrice != null)
                        Opacity(
                            opacity: 0.6,
                            child: Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: muted,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                            )),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // // small remove text (Edit/Remove)
                // GestureDetector(
                //   onTap: onRemove,
                //   child: Image.asset('assets/images/delete.png',
                //       height: 28, width: 28),
                // ),
                // const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CounterCart(onTap: onDecrement, icon:  Icons.remove),
                    const SizedBox(width: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          color:  textDark.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          color: textDark,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CounterCart(onTap: onIncrement, icon: Icons.add),
                  ],
                ),
              ],
            ),
          ]),
          const SizedBox(height: 12),
          Container(
            width: 327,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFFEBEBFA),
                ),
              ),
            ),
          ),
        ],
      );
}
