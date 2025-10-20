import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/svg.dart';

import 'package:grocery_shop_app/core/constants/app_colors.dart';
import '../../../../config/di/injection_container.dart';
import '../../../product_details/domain/usecases/get_product_details.dart';

import '../../../product_details/domain/usecases/get_similar_product.dart';
import '../../../product_details/presentation/manager/product_details/product_details_cubit.dart';
import '../../../product_details/presentation/manager/similar_product/similar_product_cubit.dart';
import '../../../product_details/presentation/screens/product_details_screen.dart';
import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.isLoading = false});

  final Product? product;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final p = product;

    return AnimatedSwitcher(
        duration: const Duration(seconds: 5),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: isLoading
            ? SizedBox(
                height: 194,
                child: Container(
                  width: 160,
                  height: 194,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F8FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                              width: 98,
                              height: 98,
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6))),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(width: 60, height: 14, color: Colors.black),
                        const SizedBox(height: 6),
                        Container(width: 90, height: 12, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) => ProductDetailsCubit(
                                      getProductDetails:
                                          sl<GetProductDetails>()),
                                ),
                                BlocProvider(
                                  create: (context) => SimilarProductCubit(
                                      getSimilarProduct:
                                          sl<GetSimilarProduct>()),
                                ),
                              ],
                              child: ProductDetailsScreen(productId: p!.id),
                            ))),
                child: SizedBox(
                  height: 194,
                  child: Container(
                    width: 160,
                    height: 194,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 98,
                            height: 98,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Center(
                              child: p != null && p.image != null
                                  ? Image.asset(
                                      p.image!,
                                      fit: BoxFit.cover,
                                    )
                                  : SvgPicture.asset(
                                      'assets/svg/empty_image.svg',
                                      height: 64,
                                      color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Image.asset('assets/images/add_icon.png',
                                  color: yellow, height: 18),
                            ),
                          ],
                        ),
                        Text(
                          '\$${(p?.price ?? 0).toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Color(0xFF1E222B),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.43,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          p?.title ?? '',
                          style: const TextStyle(
                            color: Color(0xFF61697C),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                            letterSpacing: 0.24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
