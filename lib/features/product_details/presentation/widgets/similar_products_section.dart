import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/features/product_details/presentation/manager/similar_product/similar_product_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import 'similar_product_card.dart';
import 'similar_product_shimmer.dart';

class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({super.key});
  // final List<SimilarProduct> items;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Similar',
              style: robotoBold.copyWith(
                fontSize: 18,
                color: kTextDark,
              ),
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<SimilarProductCubit, SimilarProductState>(
              builder: (context, state) {
            if (state is SimilarProductLoading ||
                state is SimilarProductInitial) {
              return const SimilarProductShimmer();
            }

            if (state is SimilarProductError) {
              return Center(child: Text(state.message));
            }

            if (state is SimilarProductLoaded) {
              final item = state.products;
              return SizedBox(
                height: 156,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    final product = item[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SimilarProductCard(product: product),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      );
}
