import 'package:flutter/material.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/images.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import 'square_item_widget.dart';

class MoreHorizontalSection extends StatelessWidget {
  const MoreHorizontalSection({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 135,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraSmall),
        child: Center(
            child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: const [
            SquareButtonWidget(
              image: Images.offerIcon,
              title: 'Offers',
              navigateTo: CartScreen(),
              count: 0,
              hasCount: false,
            ),
            SquareButtonWidget(
              image: Images.walletIcon,
              title: 'Wallet',
              navigateTo: CartScreen(),
              count: 0,
              hasCount: false,
              subTitle: 'amount',
              isWallet: true,
              // balance: profileProvider.balance,
            ),
            // SquareButtonWidget(
            //   image: Images.snackbarTickmark,
            //   title: 'Loyalty_point',
            //   navigateTo: CartScreen(),
            //   count: 1,
            //   hasCount: false,
            //   isWallet: true,
            //   subTitle: 'point',
            //   // balance: profileProvider.loyaltyPoint,
            //   isLoyalty: true,
            // ),
            SquareButtonWidget(
              image: Images.orderIcon,
              title: 'Orders',
              navigateTo: CartScreen(),
              count: 1,
              hasCount: false,
              isWallet: true,
              subTitle: 'orders',
              // balance: profileProvider.userInfoModel?.totalOrder ?? 0,
              isLoyalty: true,
            ),
            SquareButtonWidget(
              image: Images.cartImage,
              title: 'Cart',
              navigateTo: CartScreen(),
              count: 5,
              hasCount: true,
            ),
            // SquareButtonWidget(
            //   image: Images.wishlist,
            //   title: 'Wishlist',
            //   navigateTo: CartScreen(),
            //   count: 0,
            //   hasCount: true,
            // ),
          ],
        )),
      ));
}
