import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/utils/styles.dart';

import '../../../../core/utils/layout.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_snackbar_widget.dart';
import '../../../../core/widgets/success_dialog_widget.dart';
import '../../domain/entities/wishlist_product.dart';

import '../manager/cubit/wishlist_cubit.dart';
import '../widgets/wishlist_card.dart';
import '../widgets/shimmer_wishlist_card.dart';
import '../widgets/empty_wishlist.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBarWidget(label: 'Wishlist'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: BlocBuilder<WishlistCubit, WishlistState>(
              builder: (context, state) {
                if (state is WishlistInitial) {
                  context.read<WishlistCubit>().loadWishlist();
                }
                if (state is WishlistLoading) {
                  return ListView.separated(
                    itemCount: 5,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, __) => const ShimmerWishlistCard(),
                  );
                } else if (state is WishlistEmpty) {
                  return EmptyWishlist(
                      onBrowse: () => Navigator.maybePop(
                          context,
                          MaterialPageRoute<void>(
                              builder: (builder) => const Layout())));
                } else if (state is WishlistLoaded) {
                  final items = state.items;
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 160, top: 8),
                    itemCount: items.length,
                    itemBuilder: (context, idx) {
                      final WishlistProduct p = items[idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: WishlistCard(
                          product: p,
                          onRemove: (id) => _confirmRemove(context, id),
                          onToggle: (id) =>
                              context.read<WishlistCubit>().toggleFavorite(id),
                          onAddToCart: (id) {
                            showCustomSnackBarWidget(
                                'Added to cart (demo)',
                                isError: false,
                                context,
                                isToaster: true);
                          },
                        ),
                      );
                    },
                  );
                } else if (state is WishlistFailure) {
                  return Center(child: Text(state.message, style: textBold));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      );

  void _confirmRemove(BuildContext context, String id) {
    showDialog<Dialog>(
        context: context,
        builder: (_) => SuccessDialog(
              isFailed: true,
              title: 'Remove item',
              description:
                  'Do you want to remove this item from your wishlist?',
              icon: Icons.delete,
              onRemov: () {
                Navigator.of(context).pop();
                context.read<WishlistCubit>().remove(id);
                showCustomToast(
                    message:
                        'Do you want to remove this item from your wishlist?',
                    context: context);
              },
              onCancle: () => Navigator.pop(context),
            ));
  }
}
