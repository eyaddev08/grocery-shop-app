import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/injection_container.dart';
import '../../../../core/helpers/create_slide_fade_route.dart';
import '../../../product_details/domain/usecases/get_product_details.dart';
import '../../../product_details/presentation/manager/product_details/product_details_cubit.dart';
import '../../../product_details/presentation/screens/product_details_screen.dart';
import '../../../products/presentation/manager/product_cubit/product_cubit.dart';
import '../../../products/presentation/manager/product_cubit/product_state.dart';
import 'recommended_card.dart';
import 'recommended_shimmer_card.dart';

class RecommendedListView extends StatelessWidget {
  const RecommendedListView({
    super.key,
    required this.scale,
  });

  final double scale;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 194 * scale,
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.status == ProductStatus.loading ||
                state.status == ProductStatus.initial) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => const RecommendedShimmerCard(),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: 5,
              );
            } else if (state.status == ProductStatus.error) {
              return Center(child: Text(state.errorMessage));
            } else if (state.status == ProductStatus.loaded) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.recommendedProducts.length,
                itemBuilder: (context, index) {
                  final item = state.recommendedProducts[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.push(
                      context,
                      createSlideFadeRoute(
                        BlocProvider(
                          create: (_) => ProductDetailsCubit(
                              sl<GetProductDetailsUseCase>()),
                          child: ProductDetailsScreen(initialProduct: item),
                        ),
                      ),
                    ),
                    child: RecommendedCard(
                      width: 140 * scale,
                      product: item,
                      scale: scale,
                    ),
                  );
                },
              );
            }

            return SizedBox.shrink();
          },
        ),
      );
}
