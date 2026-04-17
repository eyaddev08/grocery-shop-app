import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/injection_container.dart';
import '../../../../core/helpers/create_slide_fade_route.dart';
import '../../../../core/widgets/confirm_dialog_widget.dart';
import '../../../track_order/presentation/manager/track_order_cubit.dart';
import '../../../track_order/presentation/screens/track_order_screen.dart';
import '../../domain/entities/order_entity.dart';
import '../manager/order_cubit.dart';
import 'active_order_card.dart';
import 'completed_order_card.dart';
import 'order_divider.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, required this.orders});
  final List<OrderEntity> orders;
  @override
  Widget build(BuildContext context) {
    final activeOrders = orders
        .where((o) =>
            o.status == OrderStatus.active || o.status == OrderStatus.pending)
        .toList();
    final completedOrders = orders
        .where((o) =>
            o.status != OrderStatus.active && o.status != OrderStatus.pending)
        .toList();

    return CustomScrollView(
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      slivers: [
        if (activeOrders.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final order = activeOrders[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: ActiveOrderCard(
                    order: order,
                    onTrackOrder: () => Navigator.push(
                      context,
                      createSlideFadeRoute(
                        BlocProvider(
                          create: (context) => sl<TrackOrderCubit>()
                            ..loadTrackOrder(order.id, order),
                          child:
                              TrackOrderScreen(orderId: order.id, order: order),
                        ),
                      ),
                    ),
                    onCancelOrder: () =>
                        _showCancelConfirmationDialog(context, order.id),
                  ),
                );
              },
              childCount: activeOrders.length,
            ),
          ),
        if (activeOrders.isNotEmpty && completedOrders.isNotEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: OrderDivider(),
            ),
          ),
        if (completedOrders.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final order = completedOrders[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      CompletedOrderCard(order: order),
                      if (index < completedOrders.length - 1)
                        const OrderDivider(),
                    ],
                  ),
                );
              },
              childCount: completedOrders.length,
            ),
          ),
      ],
    );
  }

  void _showCancelConfirmationDialog(BuildContext context, String orderId) {
    showDialog<Dialog>(
        context: context,
        builder: (dialogContext) => ConfirmDialogWidget(
              isFailed: true,
              title: 'Cancel Order?',
              description:
                  'Are you sure you want to cancel this order? This action cannot be undone.',
              icon: Icons.cancel_sharp,
              titleButton: 'Yes, Cancel',
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<OrderCubit>().cancelExistingOrder(orderId);
              },
              onCancle: () => Navigator.pop(context),
            ));
  }
}
