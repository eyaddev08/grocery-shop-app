import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes/app_routes.dart';
import '../../features/cart/presentation/manager/cart_cubit.dart';
import '../constants/app_colors.dart';
import '../services/navigation_service.dart';
import '../utils/styles.dart';
import '../utils/images.dart';
import 'custom_asset_image_widget.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    super.key,
    this.label = 'Hey, Halal',
    this.backgroundColor = kPrimaryBlue,
    this.titleSpacing = 18,
    this.centerTitle = false,
    this.labelSize = 22,
    this.labelColor = Colors.white,
    this.isBackButtonExist = false,
    this.showSearchIcon = true,
    this.onBackPressed,
  });
  final String label;
  final Color backgroundColor;
  final int titleSpacing;
  final int labelSize;
  final Color labelColor;
  final bool centerTitle;
  final bool isBackButtonExist;
  final bool showSearchIcon;

  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    final double scale = s(context);
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E222B)),
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
        titleSpacing: 18,
        excludeHeaderSemantics: true,
        clipBehavior: Clip.none,
        leading: isBackButtonExist
            ? Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: kTextDark.withOpacity(0.06), shape: BoxShape.circle),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: CustomAssetImageWidget(
                      Images.arrIcon,
                      height: 12,
                      width: 12,
                      color: kTextDark.withOpacity(0.8),
                    ),
                    onPressed: () => onBackPressed != null
                        ? onBackPressed!()
                        : Navigator.pop(context)),
              )
            : null,
        title: Text(label,
            style: textBold.copyWith(
              color: labelColor,
              fontSize: labelSize * scale,
            )),
        actions: [
          if (showSearchIcon)
            CustomAssetImageWidget(Images.searchIcon,
                color: labelColor, height: 22 * scale)
          else
            const SizedBox.shrink(),
          const SizedBox(width: 8),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {
                  NavigationService.navigateTo(AppRoutes.cart);
                },
                icon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomAssetImageWidget(
                    Images.bagIcon,
                    height: 22,
                    color: labelColor,
                  ),
                ),
              ),
              Positioned(
                right: 14 * scale,
                top: 6 * scale,
                child: Container(
                    width: 22 * scale,
                    height: 22 * scale,
                    decoration: BoxDecoration(
                        color: kYellow,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.white, width: 2 * scale)),
                    child: BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        int count = 0;
                        if (state is CartLoaded) count = state.items.length;

                        return Center(
                            child: Text(count.toString(),
                                style: textBold.copyWith(
                                  color: Colors.white,
                                  fontSize: 12 * scale,
                                )));
                      },
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
