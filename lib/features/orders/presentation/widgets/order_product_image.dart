import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/images.dart';

class OrderProductImage extends StatelessWidget {
  const OrderProductImage({
    super.key,
    required this.imageUrl,
    this.size = 48,
  });

  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: imageUrl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceholderImage(),
                ),
              )
            : _buildPlaceholderImage(),
      );

  Widget _buildPlaceholderImage() => SvgPicture.asset(
        Images.emptyImage,
        height: size * 0.5,
      );
}
