import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/di/injection_container.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/helpers/create_slide_fade_route.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/add_to_cart_widget.dart';
import '../../../../core/widgets/custom_image_widget.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../domain/usecases/get_product_details.dart';

import '../manager/product_details/product_details_cubit.dart';
import '../screens/product_details_screen.dart';

class SimilarProductCard extends StatelessWidget {
  const SimilarProductCard({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              createSlideFadeRoute(BlocProvider(
                create: (context) =>
                    ProductDetailsCubit(sl<GetProductDetailsUseCase>()),
                child: ProductDetailsScreen(productId: product.id),
              )));
        },
        child: Container(
          width: 140,
          decoration: const BoxDecoration(
            color: kSoftBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: kSoftBg,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomImageWidget(image: product.thumbnail ?? ''),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textBold.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          '${product.price}',
                          style: titilliumBold.copyWith(
                            color: kPrimaryBlue,
                          ),
                        ),
                        const Spacer(),
                        AddToCartWidget(
                        product: product,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
