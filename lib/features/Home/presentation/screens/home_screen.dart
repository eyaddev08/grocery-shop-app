import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/config/routes/app_routes.dart';
import 'package:grocery_shop_app/core/services/navigation_service.dart';
import 'package:grocery_shop_app/features/products/presentation/manager/product_cubit/product_cubit.dart';
import '../../../../core/utils/functions/show_within_menu.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/sliver_delegate_widget.dart';

import '../widgets/content_section.dart';
import '../widgets/header_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // keys for anchored menus

  final GlobalKey _withinKey = GlobalKey();
  String selectedWithin = '1 Hour';

  // Design width reference (the screenshot uses ~375 width). We'll scale all sizes by s.
  double s(BuildContext context) => MediaQuery.of(context).size.width / 375.0;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final scale = s(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: SliverDelegate(
                height: 82,
                child: const PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: CustomAppBarWidget(showSearchIcon: false),
                ),
              )),
          SliverPersistentHeader(
              delegate: SliverDelegate(
            height: 150,
            child: HeaderSection(
              scale: scale,
              withinKey: _withinKey,
              selectedWithin: selectedWithin,
              onSearchTap: () => NavigationService.navigateTo(
                AppRoutes.search,
              ),
              onWithinTap: () => showWithinMenu(
                  context, _withinKey, selectedWithin, (fn) => setState(() {})),
            ),
          )),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ContentSection(
                  scale: scale,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
