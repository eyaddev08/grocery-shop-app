import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_like_button_widget.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';
import '../../../cart/domain/entities/cart_item.dart' as cart_entity;
import '../../../product_details/presentation/screens/product_details_screen.dart';
import '../../domain/entities/wishlist_product.dart';

typedef OnRemove = void Function(String productId);
typedef OnToggle = void Function(String productId);
typedef OnAddToCart = void Function(String productId);

class WishlistCard extends StatelessWidget {
  const WishlistCard({
    super.key,
    required this.product,
    required this.onRemove,
    required this.onToggle,
    required this.onAddToCart,
  });
  final WishlistProduct product;
  final OnRemove onRemove;
  final OnToggle onToggle;
  final OnAddToCart onAddToCart;

  @override
  Widget build(BuildContext context) => GestureDetector(
       onTap: () => Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
                builder: (builder) =>  ProductDetailsScreen(productId: product.id),
                    )),

        child: Container(
          height: 104,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FA),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SvgPicture.asset(
                  product.imageUrl,
                  width: 98,
                  height: 95,
                  color: Colors.grey[400],
                  placeholderBuilder: (___) =>
                      Container(color: Colors.grey.shade300),
                ),
              ),
              // if (product.discount != null)
              //   Positioned(
              //     left: 9,
              //     top: 4,
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 8, vertical: 6),
              //       decoration: BoxDecoration(
              //           color: kPrimaryBlue,
              //           borderRadius: BorderRadius.circular(8)),
              //       child: Text('${product.discount}% Off',
              //           style: const TextStyle(
              //               color: Colors.white,
              //               fontSize: 10,
              //               fontWeight: FontWeight.w600)),
              //     ),
              //   ),

              const SizedBox(width: 12),

              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 14),
                          Text(product.title,
                              style: textBold.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text('\$${product.price.toStringAsFixed(2)}',
                                  style: textBold),
                              const SizedBox(width: 8),
                              if (product.oldPrice != null)
                                Text(
                                    '\$${product.oldPrice!.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        color: Color(0xFF5E596E),
                                        fontSize: 14,
                                        decoration:
                                            TextDecoration.lineThrough)),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final cubit = context.read<CartCubit>();
                              final item = cart_entity.CartItem(
                                  id: product.id,
                                  title: product.title,
                                  price: product.price,
                                  regularPrice: product.oldPrice,
                                  quantity: 1,
                                  image: product.imageUrl);
                              cubit.addItem(item);
                              showCustomSnackBarWidget(
                                  'The product has been successfully added to your basket!',
                                  context);
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Image.asset('assets/images/add_icon.png',
                                  color: kYellow, height: 18),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      CustomLikeButtonWidget(onTap: (t) async {
                        onRemove(product.id);
                        return true;
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
