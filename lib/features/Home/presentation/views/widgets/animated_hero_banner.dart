import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/images_constants.dart';
import 'promo_card.dart';

class PromoBanner {
  const PromoBanner({
    required this.image,
    required this.background,
    required this.title,
    required this.bigText,
    required this.subtitle,
  });

  final String image;
  final Color background;
  final String title;
  final String bigText;
  final String subtitle;
}

const List<PromoBanner> _promoBanners = <PromoBanner>[
  PromoBanner(
    image: ImagesConstants.seasonalFruitsArranged,
    background: kYellow,
    title: 'Get',
    bigText: '50% OFF',
    subtitle: 'On first 03 order',
  ),
  PromoBanner(
    image: ImagesConstants.fruitBasket,
    background: kBeige,
    title: 'New',
    bigText: 'Deals',
    subtitle: 'Limited time',
  ),
  PromoBanner(
    image: ImagesConstants.brightColorfulFruits,
    background: kNavInactive,
    title: 'Get',
    bigText: '40% OFF',
    subtitle: 'On first 04 order',
  ),
];

class AnimatedHeroBanner extends StatefulWidget {
  const AnimatedHeroBanner({
    super.key,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.animationDuration = const Duration(milliseconds: 550),
  });

  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration animationDuration;

  @override
  State<AnimatedHeroBanner> createState() => _AnimatedHeroBannerState();
}

class _AnimatedHeroBannerState extends State<AnimatedHeroBanner> {
  late final PageController _controller;
  int _currentPage = 0;
  Timer? _autoTimer;
  bool _userInteracting = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    // Start autoplay only after first frame so PageView has dimensions.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.autoPlay && _promoBanners.length > 1) {
        _startAutoPlay();
      }
    });
  }

  void _startAutoPlay() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (_userInteracting) return;
      final int next = (_currentPage + 1) % _promoBanners.length;
      if (mounted) {
        _controller.animateToPage(
          next,
          duration: widget.animationDuration,
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  void _stopAutoPlay() {
    _autoTimer?.cancel();
    _autoTimer = null;
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 190,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                // Detect user interaction to pause autoplay.
                if (notification.direction == ScrollDirection.idle) {
                  _userInteracting = false;
                  if (widget.autoPlay) _startAutoPlay();
                } else {
                  _userInteracting = true;
                  _stopAutoPlay();
                }
                return false;
              },
              child: PageView.builder(
                controller: _controller,
                itemCount: _promoBanners.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final PromoBanner banner = _promoBanners[index];
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // SAFEGUARD: page value only when controller has clients
                      // and dimensions are ready.
                      final double page;
                      if (_controller.hasClients &&
                          _controller.position.haveDimensions) {
                        page = _controller.page ??
                            _controller.initialPage.toDouble();
                      } else {
                        // Fallback until dimensions are available.
                        page = _controller.initialPage.toDouble();
                      }

                      final double delta = index - page;
                      final double translateX = (delta * 24).clamp(-40.0, 40.0);
                      final double scale =
                          (1 - delta.abs() * 0.08).clamp(0.88, 1.0);

                      return Transform.translate(
                        offset: Offset(translateX, 0),
                        child: Transform.scale(
                          scale: scale,
                          child: child,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        children: [
                          PromoCard(
                            width: double.infinity,
                            background: banner.background,
                            title: banner.title,
                            bigText: banner.bigText,
                            subtitle: banner.subtitle,
                            scale: 1,
                            imageSrc: banner.image,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Dots
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_promoBanners.length, (int index) {
                final bool isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: isActive ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : const Color(0xFFCECCD2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.22),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            )
                          ]
                        : null,
                  ),
                );
              }),
            ),
          ],
        ),
      );
}
