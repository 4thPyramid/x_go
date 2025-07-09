// filter_refresh_indicator.dart
import 'package:flutter/material.dart';

class FilterRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const FilterRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Colors.amber,
      backgroundColor: Colors.white,
      strokeWidth: 2.0,
      child: child,
    );
  }
}
