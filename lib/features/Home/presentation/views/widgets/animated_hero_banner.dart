import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../../core/constants/app_colors.dart';
import 'promo_card.dart';

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

  final promos = [
    {
      'image': 'assets/images/logo_image.svg',
      'bg': yellow,
      'title': 'Get',
      'big': '50% OFF',
      'sub': 'On first 03 order'
    },
    {
      'image': 'assets/images/logo_image.svg',
      'bg': beige,
      'title': 'New',
      'big': 'Deals',
      'sub': 'Limited time'
    },
    {
      'image': 'assets/images/logo_image.svg',
      'bg': navInactive,
      'title': 'Get',
      'big': '40% OFF',
      'sub': 'On first 04 order'
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0, viewportFraction: 1.0);

    // Start autoplay only after first frame so PageView has dimensions.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.autoPlay && promos.length > 1) {
        _startAutoPlay();
      }
    });
  }

  void _startAutoPlay() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (_userInteracting) return;
      final next = (_currentPage + 1) % promos.length;
      if (mounted) {
        _controller.animateToPage(next,
            duration: widget.animationDuration, curve: Curves.easeOutCubic);
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

  bool _isNetwork(String src) => src.startsWith('http');

  @override
  Widget build(BuildContext context) =>
      // final images = widget.images;
      SizedBox(
        height: 190,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                // detect user interaction to pause autoplay
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
                itemCount: promos.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) {
                  final p = promos[index];
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      // SAFEGUARD: page value only when controller has clients and dimensions are ready.
                      final double page;
                      if (_controller.hasClients &&
                          _controller.position.haveDimensions) {
                        // safe to use .page
                        page = _controller.page ??
                            _controller.initialPage.toDouble();
                      } else {
                        // fallback until dimensions are available
                        page = _controller.initialPage.toDouble();
                      }

                      final double delta = (index - page);
                      final double translateX = (delta * 24).clamp(-40.0, 40.0);
                      final double scale =
                          (1 - delta.abs() * 0.08).clamp(0.88, 1.0);

                      return Transform.translate(
                        offset: Offset(translateX, 0),
                        child: Transform.scale(
                          scale: scale,
                          alignment: Alignment.center,
                          child: child,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        // fit: StackFit.expand,
                        children: [
                          // _isNetwork(images[index])
                          //     ? Image.network(images[index], fit: BoxFit.cover)
                          //     : Image.asset(images[index], fit: BoxFit.cover),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     gradient: LinearGradient(
                          //       begin: Alignment.bottomCenter,
                          //       end: Alignment.topCenter,
                          //       colors: [
                          //         Colors.black.withOpacity(0.6),
                          //         Colors.black.withOpacity(0.15),
                          //         Colors.transparent
                          //       ],
                          //       stops: const [0.0, 0.45, 1.0],
                          //     ),
                          //   ),
                          // ),
                          // Replace center texts with a PromoCard overlay.
                          // PromoCard shows an image (network/asset) if provided, otherwise an icon.
                          PromoCard(
                            width: double.infinity,
                            background: p['bg'] as Color,
                            title: p['title'] as String,
                            bigText: p['big'] as String,
                            subtitle: p['sub'] as String,
                            scale: 1.0,
                            imageSrc: p['image'] as String,
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
              children: List.generate(promos.length, (i) {
                final bool active = i == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: active ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active ? Colors.white : const Color(0xFFCECCD2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: active
                        ? [
                            BoxShadow(
                                color: Colors.white.withOpacity(0.22),
                                blurRadius: 6,
                                offset: const Offset(0, 2))
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
