import 'package:flutter/material.dart';

class SliverDelegate extends SliverPersistentHeaderDelegate {
  SliverDelegate({required this.child, this.height = 70});
  Widget child;
  double height;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) =>
      oldDelegate.maxExtent != height ||
      oldDelegate.minExtent != height ||
      child != oldDelegate.child;
}
