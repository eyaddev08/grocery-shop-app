import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/features/product_details/presentation/manager/similar_product/similar_product_cubit.dart';
import '../../domain/entities/similar_product.dart';

import 'similar_product_card.dart';
import 'similar_product_shimmer.dart';

class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({super.key, required this.items});
  final List<SimilarProduct> items;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Similar',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E222B),
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
              return SizedBox(
                height: 156,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final product = items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SimilarProductCard(item: product),
                    );
                  },
                  itemCount: items.length,
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      );
}

