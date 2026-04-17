import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

import '../../../orders/domain/entities/order_entity.dart';
import '../manager/track_order_cubit.dart';
import '../manager/track_order_state.dart';
import '../widgets/delivery_info_section.dart';
import '../widgets/delivery_man_card.dart';
import '../widgets/order_details_section.dart';
import '../widgets/track_map_widget.dart';
import '../widgets/track_order_shimmer.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({
    super.key,
    required this.orderId,
    required this.order,
  });

  final String orderId;
  final OrderEntity order;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: 'Track Order'),
        ),
        body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
          builder: (context, state) {
            if (state is TrackOrderLoading) {
              return const TrackOrderShimmer();
            }

            if (state is TrackOrderError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: textBold.copyWith(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<TrackOrderCubit>()
                            .loadTrackOrder(orderId, order);
                      },
                      child: const Text('Retry', style: textBold),
                    ),
                  ],
                ),
              );
            }

            if (state is TrackOrderLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: 400,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const TrackMapWidget(),
                            Positioned(
                              bottom: -40,
                              left: 0,
                              right: 0,
                              child: DeliveryManCard(
                                deliveryManName:
                                    state.trackOrder.deliveryManName,
                                onChatTap: () {},
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 60),
                    // OrderStatusTimeline(
                    //   currentStatus: state.trackOrder.order.status.name,
                    // ),
                    // const SizedBox(height: 20),
                    DeliveryInfoSection(
                      deliveryTime: state.trackOrder.deliveryTime,
                      deliveryAddress: state.trackOrder.deliveryAddress,
                      distance: state.trackOrder.distance,
                    ),
                    const SizedBox(height: 20),
                    OrderDetailsSection(
                      orderId: state.trackOrder.orderId,
                      order: state.trackOrder.order,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );
}
