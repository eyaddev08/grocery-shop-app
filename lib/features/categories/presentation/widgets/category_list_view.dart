import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/injection_container.dart';
import '../../../../core/helpers/create_slide_fade_route.dart';
import '../../../products/presentation/manger/products_cubit.dart';
import '../../../products/presentation/screens/products_screen.dart';
import '../../domain/entities/category.dart';
import 'category_card.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
    required this.category,
  });

  final List<Category> category;

  @override
  Widget build(BuildContext context) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: category.length,
        padding: const EdgeInsets.all(18),
        itemBuilder: (context, index) {
          final c = category[index];
          return CategoriesCard(
              category: c,
              onTap: () {
                // NavigationService.navigateTo(
                //   AppRoutes.products,
                //   arguments: {
                //     'categoryId': c.id,
                //     'title': c.title,
                //   },
                // );
                Navigator.push(
                  context,
                  createSlideFadeRoute(
                    BlocProvider(
                      create: (ctx) =>
                          sl<ProductsCubit>()..loadProducts(categoryId: c.id),
                      child: ProductsScreen(categoryTitle: c.title),
                    ),
                  ),
                );
              });
        },
      );
}
