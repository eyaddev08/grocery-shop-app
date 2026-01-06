import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_like_button_widget.dart';

class ProductInfoTitle extends StatelessWidget {
  const ProductInfoTitle({super.key, required this.title, required this.isLiked});
  final String title;

  final bool isLiked;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              CustomLikeButtonWidget(onTap: (isLiked) async {
                isLiked = isLiked;

                return !isLiked;
              })
            ],
          ),
        ),
      );
}
