import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_shop_app/core/utils/images.dart';
import '../../features/Home/presentation/screens/home_screen.dart';
import '../../features/categories/presentation/screens/categories_screen.dart';
import '../../features/more/presentation/screens/more_screen.dart';
import '../../features/wishlist/presentation/screens/wishlist_screen.dart';
import '../constants/app_colors.dart';
import '../widgets/bottom_nav_item.dart';
import 'functions/show_exit_dialog.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _pageIndex = 0;

  final _pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const WishlistScreen(),
    const MoreScreen(),
  ];

  void _onNav(int idx) => setState(() => _pageIndex = idx);

  Future<void> _onWillPop(bool didPop) async {
    if (_pageIndex != 0) {
      setState(() => _pageIndex = 0);
      return;
    }
    final shouldExit = await showExitDialog(context);
    if (shouldExit) await SystemNavigator.pop();
    return;
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        onPopInvoked: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: _pageIndex,
            children: _pages,
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12 * 1.0, vertical: 10 * 1.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 14,
                      offset: Offset(0, -4))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 0; i < 4; i++)
                  _buildNavItem(
                    i,
                    i == 0
                        ? Images.homeIcon
                        : (i == 1
                            ? Images.categoryIcon
                            : (i == 2
                                ? Images.favouriteIcon
                                : Images.moreIcon)),
                    i == 0
                        ? 'Home'
                        : (i == 1
                            ? 'Categories'
                            : (i == 2 ? 'Favourite' : 'More')),
                    1,
                  ),
              ],
            ),
          ),
        ),
      );

  Widget _buildNavItem(int index, String icon, String label, double scale) {
    final isSelected = _pageIndex == index;
    if (isSelected) {
      return InkWell(
        onTap: () => _onNav(index),
        borderRadius: BorderRadius.circular(12 * scale),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48 * scale,
              height: 48 * scale,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color: homeCircleDark,
                  borderRadius: BorderRadius.circular(12 * scale)),
              child: SvgPicture.asset(icon, color: kAccentYellow),
            ),
            SizedBox(height: 6 * scale),
            const SizedBox.shrink(),
          ],
        ),
      );
    }
    return BottomNavItem(
      icon: icon,
      label: label,
      active: false,
      activeColor: kPrimaryBlue,
      inactiveColor: kNavInactive,
      onTap: () => _onNav(index),
      scale: scale,
    );
  }
}
