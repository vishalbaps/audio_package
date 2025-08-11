import 'dart:math';

import 'package:flutter/material.dart';

SliverPersistentHeader makeHeader(
  String headerTitle, {
  VoidCallback? onPress,
  Color? color,
  TextStyle? textStyle,
  Color? textColor,
}) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: _SliverAppBarDelegate(
      minHeight: 50.0,
      maxHeight: 50.0,
      child: InkWell(
        onTap: onPress,
        child: Container(
          color: color,
          alignment: Alignment.center,
          child: Text(
            headerTitle,
            style: textStyle ?? TextStyle(color: textColor ?? Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.minHeight, required this.maxHeight, required this.child});

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
