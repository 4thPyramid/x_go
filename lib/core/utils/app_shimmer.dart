import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double? radius, height, width, lPadding;
  final bool? avatar;
  final Widget? child;

  const AppShimmer({
    super.key,
    this.radius,
    this.height,
    this.child,
    this.width,
    this.avatar,
    this.lPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[50]!,
      child: avatar == true
          ? CircleAvatar(
              radius: radius ?? 35.r,
            )
          : Container(
              width: width,
              height: height,
              margin: EdgeInsets.only(left: lPadding ?? 0),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 7.r),
                color: Colors.grey[50]!,
              ),
              child: child,
            ),
    );
  }
}
