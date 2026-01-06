import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_image_widget.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
    required this.images,
    this.height = 241,
  });
  final List<String> images;
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
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                    
                    return Center(
                      child: Container(
                        width: 241,
                        height: 241,
                        decoration: BoxDecoration(
                          color: kSoftBg,
                          borderRadius: BorderRadius.circular(180),
                        ),
                        child: Center(
                          child: CustomImageWidget(image: img),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
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
