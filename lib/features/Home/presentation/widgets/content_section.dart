import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/helpers/create_slide_fade_route.dart';

import '../../../products/presentation/manager/product_cubit/product_cubit.dart';
import '../../../products/presentation/manager/product_cubit/product_state.dart';
import '../../../products/presentation/screens/products_screen.dart';
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
        TitleBody(
            title: 'Recommended',
            onTap: () {
              // NavigationService.navigateTo(AppRoutes.recommendedProducts);
              Navigator.push(
                context,
                createSlideFadeRoute(
                  const ProductsScreen(
                      title: 'Recommended',
                      source: ProductSource.recommended),
                ),
              );
            },
            scale: scale),
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
        TitleBody(
            title: 'Deals on Fruits & Tea',
            onTap: () {
              // NavigationService.navigateTo(AppRoutes.deals);
              Navigator.push(
                context,
                createSlideFadeRoute(
                  const ProductsScreen(
                      title: 'Special Deals', source: ProductSource.deals),
                ),
              );
            },
            scale: scale),
        const SizedBox(height: 12),
        BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
          if (state.status == ProductStatus.loading ||
              state.status == ProductStatus.initial) {
            return const DealsProductShimmerGridView();
          }

          if (state.status == ProductStatus.error) {
            return Center(child: Text(state.errorMessage, style: textBold));
          } else if (state.status == ProductStatus.loaded) {
            return DealsProductsGridView(
                scale: scale, product: state.dealsProducts);
          } else {
            return SizedBox.shrink();
          }
        }),
        const SizedBox(height: 50),
      ]);
}
