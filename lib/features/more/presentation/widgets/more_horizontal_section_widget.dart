import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:grocery_shop_app/features/orders/presentation/manager/order_cubit.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/images.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../orders/presentation/manager/order_state.dart';
import '../../../orders/presentation/screens/orders_screen.dart';
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
          children: [
            const SquareButtonWidget(
              image: Images.offerIcon,
              title: 'Offers',
              navigateTo: CartScreen(),
              count: 0,
              hasCount: false,
            ),
            // const SquareButtonWidget(
            //   image: Images.walletIcon,
            //   title: 'Wallet',
            //   navigateTo: WalletScreen(),
            //   count: 0,
            //   hasCount: false,
            //   subTitle: 'amount',
            //   isWallet: true,
            //   // balance: profileProvider.balance,
            // ),
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

            BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
              int ordersCount = 0;
              if (state is OrderLoaded) ordersCount = state.orders.length;
              return SquareButtonWidget(
                image: Images.orderIcon,
                title: 'Orders',
                navigateTo: const OrdersScreen(),
                count: ordersCount,
                hasCount: true,
                // balance: profileProvider.userInfoModel?.totalOrder ?? 0,
                isLoyalty: true,
              );
            }),
            BlocBuilder<CartCubit, CartState>(
              builder: (ctx, state) {
                int count = 0;
                if (state.status == CartStatus.loaded) count = state.items.length;

                return SquareButtonWidget(
                  image: Images.cartImage,
                  title: 'Cart',
                  navigateTo: const CartScreen(),
                  count: count,
                  hasCount: true,
                );
              },
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
