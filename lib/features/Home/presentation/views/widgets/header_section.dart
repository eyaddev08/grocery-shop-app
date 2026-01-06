import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import 'search_home_page_widget.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.scale,
    required this.addressKey,
    required this.withinKey,
    required this.selectedAddress,
    required this.selectedWithin,
    required this.onSearchTap,
    required this.onAddressTap,
    required this.onWithinTap,
  });
  final double scale;
  final GlobalKey addressKey;
  final GlobalKey withinKey;
  final String selectedAddress;
  final String selectedWithin;
  final VoidCallback onSearchTap;
  final Future<void> Function() onAddressTap;
  final Future<void> Function() onWithinTap;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 18 * scale),
        decoration: BoxDecoration(
          color: kPrimaryBlue,
          border: Border.all(color: kPrimaryBlue, width: 0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 13 * scale),
            InkWell(
              onTap: onSearchTap,
              child: Hero(
                  tag: 'search',
                  child: Material(
                      color: kSearchBlue,
                      borderRadius: BorderRadius.circular(28),
                      child: SearchHomePageWidget(scale: scale))),
            ),
            SizedBox(height: 28 * scale),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Text('DELIVERY TO',
                            style: titilliumSemiBold.copyWith(
                              color: kSoftBg,
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                      SizedBox(height: 4 * scale),
                      InkWell(
                        key: addressKey,
                        onTap: onAddressTap,
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(selectedAddress,
                                    style: titleRegular.copyWith(
                                      color: Colors.white,
                                    ))),
                            SizedBox(width: 6 * scale),
                            Icon(Icons.keyboard_arrow_down,
                                color: Colors.white, size: 18 * scale)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  key: withinKey,
                  onTap: onWithinTap,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.50,
                        child: Text('WITHIN',
                            style: titilliumSemiBold.copyWith(
                              color: kSoftBg,
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                      SizedBox(height: 4 * scale),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(selectedWithin,
                              style: titleRegular.copyWith(
                                color: kPale,
                                fontSize: 13,
                              )),
                          const SizedBox(width: 6),
                          Icon(Icons.keyboard_arrow_down,
                              color: Colors.white, size: 18 * scale)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
}
