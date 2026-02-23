import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/injection_container.dart';
import '../../../product_details/domain/usecases/get_product_details.dart';
import '../../../product_details/presentation/manager/product_details/product_details_cubit.dart';
import '../../../product_details/presentation/screens/product_details_screen.dart';
import '../../domain/entities/recommended_product.dart';
import '../manager/recommended/recommended_cubit.dart';
import 'recommended_card.dart';

class RecommendedListView extends StatelessWidget {
  const RecommendedListView({
    super.key,
    required this.scale,
  });

  final double scale;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 194 * scale,
        child: BlocBuilder<RecommendedCubit, RecommendedState>(
          builder: (context, state) {
            if (state is RecommendedInitial || state is RecommendedLoading) {
              context.read<RecommendedCubit>().load();
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RecommendedError) {
              return Center(child: Text(state.message));
            }

            final List<RecommendedProduct> items =
                state is RecommendedLoaded ? state.items : [];

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final entity = item.toEntity();

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => BlocProvider(
                        create: (_) =>
                            ProductDetailsCubit( sl<GetProductDetails>()),
                        child: ProductDetailsScreen(initialProduct: entity),
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
          },
        ),
      );
}
