import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/functions/show_address_menu.dart';
import '../../../../core/utils/functions/show_within_menu.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/sliver_delegate_widget.dart';
import '../manager/deal_product/deal_product_cubit.dart';
import 'widgets/content_section.dart';
import 'widgets/header_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // keys for anchored menus
  final GlobalKey _addressKey = GlobalKey();
  final GlobalKey _withinKey = GlobalKey();
  String selectedAddress = 'Green Way 3000, Sylhet';
  String selectedWithin = '1 Hour';

  // Design width reference (the screenshot uses ~375 width). We'll scale all sizes by s.
  double s(BuildContext context) => MediaQuery.of(context).size.width / 375.0;

  @override
  void initState() {
    super.initState();
    context.read<DealProductCubit>().loadProducts();
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
              addressKey: _addressKey,
              withinKey: _withinKey,
              selectedAddress: selectedAddress,
              selectedWithin: selectedWithin,
              onSearchTap: () =>
                  Navigator.of(context).push<Widget>(MaterialPageRoute<Widget>(
                builder: (_) => const SizedBox(),
              )),
              onAddressTap: () => showAddressMenu(context, _addressKey,
                  selectedAddress, (fn) => setState(() {})),
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
