import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    super.key,
   
  });



  @override
  Widget build(BuildContext context){ 
    final double scale = s(context);
    return PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: false,
          backgroundColor: deepBlue,
          centerTitle: false,
          titleSpacing: 18,
          excludeHeaderSemantics: true,
          clipBehavior: Clip.none,
          title: Text('Hey, Halal',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w600)),
          actions: [
            Image.asset('assets/images/icons_search.png',
                color: Colors.white, height: 22 * scale),
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
                          color: yellow,
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
      );}
}
