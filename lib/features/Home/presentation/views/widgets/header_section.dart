import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

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
  Widget build(BuildContext context) => SizedBox(
        height: 260 * scale,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 240 * scale,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                  18 * scale, 14 * scale, 18 * scale, 14 * scale),
              decoration: const BoxDecoration(
                color: kPrimaryBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hey, Halal',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22 * scale,
                              fontWeight: FontWeight.w600)),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.notifications_none,
                                  color: Colors.white, size: 22 * scale)),
                          Positioned(
                            right: 8 * scale,
                            top: 6 * scale,
                            child: Container(
                                width: 22 * scale,
                                height: 22 * scale,
                                decoration: BoxDecoration(
                                    color: kYellow,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2 * scale)),
                                child: Center(
                                    child: Text('3',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12 * scale,
                                            fontWeight: FontWeight.w600,
                                            height: 1)))),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20 * scale),
                  GestureDetector(
                    onTap: onSearchTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16 * scale, vertical: 12 * scale),
                      decoration: BoxDecoration(
                          color: kSearchBlue,
                          borderRadius: BorderRadius.circular(28 * scale)),
                      child: Row(
                        children: [
                          Icon(Icons.search,
                              color: Colors.white60, size: 18 * scale),
                          SizedBox(width: 12 * scale),
                          Expanded(
                              child: Text('Search Products or store',
                                  style: TextStyle(
                                      color: const Color(0xFF8791A5),
                                      fontSize: 14 * scale,
                                      fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 35 * scale),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: Text('DELIVERY TO',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11 * scale,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.22)),
                            ),
                            SizedBox(height: 4 * scale),
                            InkWell(
                              key: addressKey,
                              onTap: onAddressTap,
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text(selectedAddress,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14 * scale,
                                              fontWeight: FontWeight.w500))),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.keyboard_arrow_down,
                                      color: Colors.white, size: 18)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        key: withinKey,
                        onTap: onWithinTap,
                        child:
                            //  Container(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 8 * scale, vertical: 6 * scale),
                            //   decoration: BoxDecoration(
                            //       color: const Color(0xFF183b6a),
                            //       borderRadius: BorderRadius.circular(8 * scale)),
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: 0.50,
                              child: Text('WITHIN',
                                  style: TextStyle(
                                      color: const Color(0xFFF7F8FA),
                                      fontSize: 11 * scale,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.22)),
                            ),
                            SizedBox(height: 4 * scale),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(selectedWithin,
                                    style: TextStyle(
                                        color: const Color(0xFFF7F8FA),
                                        fontSize: 13 * scale,
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(width: 6),
                                const Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white, size: 18)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
