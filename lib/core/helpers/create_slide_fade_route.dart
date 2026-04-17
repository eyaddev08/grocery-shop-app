import 'package:flutter/material.dart';

Route<dynamic> createSlideFadeRoute(Widget page, {RouteSettings? settings}) =>
    PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 480),
      reverseTransitionDuration: const Duration(milliseconds: 380),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offset = Tween<Offset>(
                begin: const Offset(1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
        final opacity = Tween<double>(begin: 5, end: 5)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));
        return SlideTransition(
          position: offset,
          child: FadeTransition(opacity: opacity, child: child),
        );
      },
    );
