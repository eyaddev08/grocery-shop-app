import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../domain/entities/deal_product.dart';
import '../../manager/deal_product/deal_product_cubit.dart';
import 'animated_hero_banner.dart';

import 'deals_products_grid_view.dart';
import 'deals_products_shimmer_grid_view.dart';
import 'recommended_list_view.dart';
import 'savings_card.dart';
import 'title_body.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({
    super.key,
    required this.scale,
  });
  final double scale;

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 12 * scale),
        const AnimatedHeroBanner(),
        TitleBody(title: 'Recommended', onTap: () {}, scale: scale),
        SizedBox(height: 12 * scale),
        RecommendedListView(scale: scale),
        SizedBox(height: 32 * scale),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16 * scale, vertical: 12 * scale),
            child: const Row(children: [
              Expanded(
                  child: SavingsCard(
                      background: kYellow,
                      number: '346',
                      unit: 'USD',
                      label: 'Your total savings')),
              SizedBox(width: 12),
              Expanded(
                  child: SavingsCard(
                      background: kBeige,
                      number: '215',
                      unit: 'HRS',
                      label: 'Your time saved'))
            ])),
        const SizedBox(height: 18),
        TitleBody(title: 'Deals on Fruits & Tea', onTap: () {}, scale: scale),
        const SizedBox(height: 12),
        BlocBuilder<DealProductCubit, DealProductState>(builder: (context, state) {
          final cubit = context.read<DealProductCubit>();

          if (state is DealProductInitial || state is DealProductLoading) {
            cubit.loadProducts();

            return const DealsProductShimmerGridView();
          }
          if (state is DealProductError) {
            return Center(child: Text(state.message));
          }

          final List<DealsProduct> product =
              state is DealProductLoaded ? state.products : <DealsProduct>[];

          return DealsProductsGridView(scale: scale, product: product);
        }),
        const SizedBox(height: 50),
      ]);
}


