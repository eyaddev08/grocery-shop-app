import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/filters_card_widget.dart';
import '../manger/categories_cubit.dart';
import '../manger/categories_state.dart';
import '../widgets/category_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _filterIndex = 0;

  void _onFilter(int idx) => setState(() => _filterIndex = idx);

  @override
  Widget build(BuildContext context) {
    final double scale = s(context);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBarWidget(),
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CategoriesError) {
            return Center(child: Text(state.message));
          }
          if (state is CategoriesLoaded) {
            final items = state.categories;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                        18 * scale, 14 * scale, 18 * scale, 14 * scale),
                    decoration: const BoxDecoration(
                      color: kPrimaryBlue,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 77,
                        ),
                        Text(
                          'Shop',
                          style: TextStyle(
                            color: Color(0xFFFAFAFC),
                            fontSize: 50,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            height: 1.25,
                          ),
                        ),
                        Text(
                          'By Category',
                          style: TextStyle(
                            color: Color(0xFFFAFAFC),
                            fontSize: 50,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final filter = items[index];
                        final isSelected = _filterIndex == index;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: FiltersCardWidget(
                            filterName: filter.filterName,
                            active: isSelected,
                            onTap: () => _onFilter(index),
                          ),
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: items.length,
                    padding: const EdgeInsets.all(18),
                    itemBuilder: (context, index) {
                      final c = items[index];
                      return CategoriesCard(
                          category: c,
                          onTap: () {
                            NavigationService.navigateTo(AppRoutes.products);
                          });
                    },
                  )
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
