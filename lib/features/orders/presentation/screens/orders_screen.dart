import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/config/routes/app_routes.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../../core/widgets/no_items_widget.dart';

import '../manager/order_cubit.dart';
import '../manager/order_state.dart';

import '../widgets/order_shimmer.dart';
import '../widgets/orders_list_view.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: 'Orders'),
        ),
        body: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is OrderActionSuccess) {
              showCustomSnackBarWidget(state.message, context);
              context.read<OrderCubit>().loadOrders();
            } else if (state is OrderActionError) {
              showCustomToast(
                  message: state.message, context: context, isSuccess: false);
            }
          },
          builder: (context, state) {
            if (state is OrderLoading) {
              return const OrderShimmer();
            } else if (state is OrderError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: textBold.copyWith(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      buttonText: 'Retry',
                      onPressed: () => context.read<OrderCubit>().loadOrders(),
                      buttonWidth: 200,
                    ),
                  ],
                ),
              );
            } else if (state is OrderLoaded || state is OrderActionLoading) {
              final orders = context.read<OrderCubit>().currentOrders;

              return Stack(
                children: [
                  RefreshIndicator(
                    backgroundColor: Colors.white,
                    color: kAccentYellow,
                    onRefresh: () async {
                      await context.read<OrderCubit>().loadOrders();
                    },
                    child: orders.isEmpty
                        ? CustomScrollView(
                            slivers: [
                              SliverFillRemaining(
                                child: Center(
                                  child: NoItemsWidget(
                                    message: 'No orders found',
                                    buttonTitle: 'Shop now',
                                    image: Images.noOrder,
                                    onShowAll: () =>
                                        NavigationService.navigateTo(
                                            AppRoutes.cart),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : OrdersListView(orders: orders),
                  ),
                  if (state is OrderActionLoading)
                    ColoredBox(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(
                          child:
                              CircularProgressIndicator(color: kAccentYellow)),
                    ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );
}
