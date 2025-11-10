import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../cart/presentation/manager/cart_cubit.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = s(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: kTextDark.withOpacity(0.06), shape: BoxShape.circle),
            child: IconButton(
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  'assets/svg/arr_icon.svg',
                  height: 12,
                  width: 12,
                  color: kTextDark.withOpacity(0.8),
                ),
                onPressed: () => Navigator.of(context).maybePop()),
          ),
          const Spacer(),
          SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: kTextDark.withOpacity(0.06), shape: BoxShape.circle),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/svg/bag_icon.svg',
                        height: 22,
                        color: Colors.black54,
                      ),
                    ),
                    Positioned(
                      right: 0 * scale,
                      top: 3 * scale,
                      child: Container(
                        width: 22 * scale,
                        height: 22 * scale,
                        decoration: BoxDecoration(
                          color: kAccentYellow,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white, width: 2 * scale),
                        ),
                        child: Center(child: BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            int count = 0;
                            if (state is CartLoaded) count = state.items.length;

                            return Center(
                                child: Text(count.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12 * scale,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      height: 1,
                                    )));
                          },
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
