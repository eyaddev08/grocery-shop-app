import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../constants/app_colors.dart';

class CustomLikeButtonWidget extends StatelessWidget {
  const CustomLikeButtonWidget({
    super.key,
    this.onTap,
    this.isLiked = false,
  });
  final Future<bool?> Function(bool)? onTap;
  final bool isLiked;

  @override
  Widget build(BuildContext context) => Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
            color: kTextDark.withOpacity(0.06), shape: BoxShape.circle),
        child: LikeButton(
          isLiked: isLiked,
          likeCountPadding: EdgeInsets.zero,
          likeBuilder: (isLiked) => Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.redAccent : Colors.grey,
            size: 24,
          ),
          circleColor: const CircleColor(
              start: Colors.redAccent, end: Colors.deepOrange),
          bubblesColor: const BubblesColor(
            dotPrimaryColor: Colors.red,
            dotSecondaryColor: Colors.orange,
          ),
          onTap: onTap,
        ),
      );
}
