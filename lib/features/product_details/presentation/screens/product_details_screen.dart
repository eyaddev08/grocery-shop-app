import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../manager/product_details/product_details_cubit.dart';
import '../manager/similar_product/similar_product_cubit.dart';
import '../widgets/action_buttons_row.dart';
import '../widgets/image_carousel.dart';
import '../widgets/product_info_section.dart';
import '../widgets/product_info_title.dart';
import '../widgets/product_nutritional_info.dart';
import '../widgets/product_price_row.dart';
import '../widgets/product_rating_row.dart';
import '../widgets/product_reviews_tile.dart';
import '../widgets/similar_products_section.dart';
import '../widgets/product_detail_shimmer.dart';
import '../widgets/top_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, this.productId, this.initialProduct});
  final String? productId;
  final ProductEntity? initialProduct;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final double designW = screenW < 375 ? screenW : 375.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider.value(
        value: BlocProvider.of<ProductDetailsCubit>(context)
          ..load(id: productId, initialProduct: initialProduct),
        child: SafeArea(child: ProductDetailBody(designW: designW)),
      ),
    );
  }
}

class ProductDetailBody extends StatelessWidget {
  const ProductDetailBody({
    super.key,
    required this.designW,
  });

  final double designW;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading ||
              state is ProductDetailsInitial) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  children: [
                    const TopBar(),
                    const SizedBox(height: 6),
                    ShimmerProductDetail(designW: designW),
                  ],
                ),
              ),
            );
          }

          if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is ProductDetailsLoaded) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopBar(),
                    const SizedBox(height: 6),
                    ImageCarousel(images: state.details.images),
                    const SizedBox(height: 8),
                    ProductInfoTitle(
                        title: state.details.name,
                        isLiked: state.details.inWishlist),
                    const SizedBox(height: 12),
                    ProductPriceRow(details: state.details),
                    const SizedBox(height: 12),
                    const ProductRatingRow(),
                    const SizedBox(height: 18),
                    ActionButtonsRow(details: state.details),
                    const SizedBox(height: 20),
                    ProductInfoSection(
                        desc: state.details.shortDescription ?? ''),
                    const SizedBox(height: 18),
                    ProductNutritionalInfo(
                        nutrition: state.details.nutritionLines),
                    const SizedBox(height: 4),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(color: kMutedGray, height: 1),
                    ),
                    const SizedBox(height: 6),
                    const ProductReviewsTile(),
                    const SizedBox(height: 6),
                    BlocProvider.value(
                      value: BlocProvider.of<SimilarProductCubit>(context)
                        ..load(state.details.id),
                      child: const SimilarProductsSection(),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      );
}
