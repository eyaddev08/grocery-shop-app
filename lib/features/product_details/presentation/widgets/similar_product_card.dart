import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/di/injection_container.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/similar_product.dart';
import '../../domain/usecases/get_product_details.dart';

import '../manager/product_details/product_details_cubit.dart';
import '../screens/product_details_screen.dart';

class SimilarProductCard extends StatelessWidget {
  const SimilarProductCard({super.key, required this.item});
  final SimilarProduct item;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => BlocProvider(
                        create: (context) => ProductDetailsCubit(
                            getProductDetails: sl<GetProductDetails>()),
                        child: ProductDetailsScreen(productId: item.id),
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
                      child: SvgPicture.asset(item.image),
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
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E222B)),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          item.price,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryBlue,
                          ),
                        ),
                        const Spacer(),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
