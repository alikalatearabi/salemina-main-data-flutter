// lib/widgets/sticky_header_delegate.dart
import 'package:flutter/material.dart';

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;
  final Color backgroundColor;

  StickyHeaderDelegate({
    required this.height,
    required this.child,
    this.backgroundColor = Colors.white,
  });

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: overlapsContent || shrinkOffset > 0 ? 2.0 : 0.0,
      color: backgroundColor.withOpacity(0.98),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 0.5)),
        ),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(StickyHeaderDelegate oldDelegate) {
    return height != oldDelegate.height ||
        child != oldDelegate.child ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}