// ----------------- IMAGE CAROUSEL (swipe + dots) -----------------
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
    required this.images,
    this.height = 241,
  });
  final List<String> images; // asset paths or network URLs
  final double height;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late final PageController _controller;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1, initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: widget.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.images.length,
                  onPageChanged: (p) => setState(() => _current = p),
                  itemBuilder: (context, index) {
                    final img = widget.images[index];
                    // detect if asset or network (simple heuristic)
                    final isNetwork = img.startsWith('http');
                    return Center(
                      child: Container(
                        width: 241,
                        height: 241,
                        decoration: BoxDecoration(
                          color: kSoftBg,
                          borderRadius: BorderRadius.circular(180),
                        ),
                        child: Center(
                          child: isNetwork
                              ? Image.network(img, fit: BoxFit.contain)
                              : SvgPicture.asset('assets/svg/empty_image.svg'),
                        ),
                      ),
                    );
                  },
                ),

                // left / right small arrows (optional; tap to change)
                // Positioned(
                //   left: 6,
                //   child: GestureDetector(
                //     onTap: () {
                //       final prev =
                //           (_current - 1).clamp(0, widget.images.length - 1);
                //       _animateTo(prev);
                //     },
                //     child: Container(
                //       width: 36,
                //       height: 36,
                //       decoration: BoxDecoration(
                //         color: Colors.white.withOpacity(0.7),
                //         shape: BoxShape.circle,
                //       ),
                //       child: const Icon(Icons.chevron_left,
                //           size: 22, color: Colors.black54),
                //     ),
                //   ),
                // ),
                // Positioned(
                //   right: 6,
                //   child: GestureDetector(
                //     onTap: () {
                //       final next =
                //           (_current + 1).clamp(0, widget.images.length - 1);
                //       _animateTo(next);
                //     },
                //     child: Container(
                //       width: 36,
                //       height: 36,
                //       decoration: BoxDecoration(
                //         color: Colors.white.withOpacity(0.7),
                //         shape: BoxShape.circle,
                //       ),
                //       child: const Icon(Icons.chevron_right,
                //           size: 22, color: Colors.black54),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),

          // dots indicator (animated)
          const SizedBox(height: 6),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.images.length, (i) {
              final bool active = i == _current;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 22 : 10,
                height: 6,
                decoration: BoxDecoration(
                  color: active ? kAccentYellow : const Color(0xFFE4E4E4),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: kAccentYellow.withOpacity(0.26),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
              );
            }),
          ),
        ],
      );
}
