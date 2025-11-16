import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/orders_cubit.dart';
import '../manager/orders_state.dart';
import '../widgets/active_order_card.dart';
import '../widgets/completed_order_card.dart';
import '../widgets/order_divider.dart';
import '../widgets/order_shimmer.dart';
import '../../domain/entities/order.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'Orders'),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const OrderShimmer();
          }

          if (state is OrdersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OrdersCubit>().loadOrders();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is OrdersLoaded) {
            final orders = state.orders;
            if (orders.isEmpty) {
              return const Center(
                child: Text(
                  'No orders found',
                  style: TextStyle(
                    color: Color(0xFF61697C),
                    fontSize: 16,
                  ),
                ),
              );
            }

            // Separate active and completed orders
            final activeOrders =
                orders.where((o) => o.status == OrderStatus.active).toList();
            final completedOrders =
                orders.where((o) => o.status != OrderStatus.active).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Active orders
                  ...activeOrders.map((order) => ActiveOrderCard(order: order)),

                  // Divider if there are both active and completed orders
                  if (activeOrders.isNotEmpty && completedOrders.isNotEmpty)
                    const OrderDivider(),

                  // Completed orders
                  ...completedOrders.asMap().entries.map((entry) {
                    final index = entry.key;
                    final order = entry.value;
                    return Column(
                      children: [
                        CompletedOrderCard(order: order),
                        if (index < completedOrders.length - 1)
                          const OrderDivider(),
                      ],
                    );
                  }),
                ],
              ),
            );
          }

          // Initial state
          return const SizedBox.shrink();
        },
      ),
    );
}
