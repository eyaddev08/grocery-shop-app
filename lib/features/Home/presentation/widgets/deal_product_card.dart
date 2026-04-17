import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/injection_container.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/helpers/create_slide_fade_route.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/add_to_cart_widget.dart';
import '../../../../core/widgets/custom_image_widget.dart';
import '../../../product_details/presentation/manager/product_details/product_details_cubit.dart';
import '../../../product_details/presentation/screens/product_details_screen.dart';
import '../../../products/domain/entities/product_entity.dart';
import 'deal_product_shimmer_card.dart';

class DealProductCard extends StatelessWidget {
  const DealProductCard(
      {super.key, required this.product, this.isLoading = false});

  final ProductEntity? product;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
      duration: const Duration(seconds: 5),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: isLoading
          ? const DealProductShimmerCard()
          : InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.push(
                context,
                createSlideFadeRoute(
                  BlocProvider(
                    create: (_) => sl<ProductDetailsCubit>(),
                    child: ProductDetailsScreen(initialProduct: product),
                  ),
                ),
              ),
              child: Container(
                width: 164,
                height: 194,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: kSoftBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 98,
                        height: 98,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Center(
                          child: CustomImageWidget(
                              image: product?.thumbnail ?? Images.emptyImage,
                              height: 64,
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    AddToCartWidget(
                       product: product!),
                    Row(
                      children: [
                        Text(
                          '\$${product!.price.toStringAsFixed(0)}',
                          style: textBold,
                        ),
                        const SizedBox(width: 8),
                        if (product!.originalPrice != null)
                          Opacity(
                              opacity: 0.6,
                              child: Text(
                                '\$${product!.originalPrice?.toStringAsFixed(2)}',
                                style: textBold.copyWith(
                                  color: kMuted,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              )),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product!.name,
                      style: titilliumRegular.copyWith(
                        color: kMuted,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ));
}
