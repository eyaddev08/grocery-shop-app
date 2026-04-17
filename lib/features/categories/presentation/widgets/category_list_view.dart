import 'package:flutter/material.dart';
import 'package:grocery_shop_app/features/products/presentation/manager/product_cubit/product_state.dart';

import '../../../../core/helpers/create_slide_fade_route.dart';
import '../../../../core/helpers/json_converter.dart';
import '../../../products/presentation/screens/products_screen.dart';
import '../../domain/entities/category_entity.dart';
import 'category_card.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
    required this.category,
  });

  final List<CategoryEntity> category;

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
                Navigator.push(
                  context,
                  createSlideFadeRoute(
                    ProductsScreen(title: c.name, categoryId: JsonConverter.parseInt(c.id), source: ProductSource.category,),
                  ),
                );
              });
        },
      );
}
