import 'package:flutter/material.dart';

class TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  const TabBarHeaderDelegate({required this.child});

  final Widget child;

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 64;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;

  @override
  bool shouldRebuild(covariant TabBarHeaderDelegate oldDelegate) => oldDelegate.child != child;
}
