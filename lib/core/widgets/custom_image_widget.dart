import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../utils/images.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.fit = BoxFit.cover,
      this.placeholder = Images.emptyImage});
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        placeholder: (context, url) => SvgPicture.asset(
            placeholder ?? Images.emptyImage,
            color: kEmptyImage,
            height: height,
            width: width),
        imageUrl: image,
        fit: fit ?? BoxFit.cover,
        height: height,
        width: width,
        errorWidget: (c, o, s) => SvgPicture.asset(
            placeholder ?? Images.emptyImage,
            color: kEmptyImage,
            height: height,
            width: width),
      );
}
