import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

class CustomTabContainer extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Widget? icon;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;

  const CustomTabContainer({
    super.key,
    required this.isSelected,
    required this.text,
    this.icon,
    required this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(5.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, SizedBox(height: 4.h)],
            Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : AppColors.grey.withOpacity(.8),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<TabItem> tabs;
  final Function(int) onTabSelected;
  final Color? backgroundColor;
  final BorderRadius? containerBorderRadius;
  final BorderRadius? tabBorderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomTabBar({
    Key? key,
    required this.selectedIndex,
    required this.tabs,
    required this.onTabSelected,
    this.backgroundColor,
    this.containerBorderRadius,
    this.tabBorderRadius,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 11.h),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white,
          borderRadius: containerBorderRadius ?? BorderRadius.circular(8.r),
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final tab = tabs[index];
            return Expanded(
              child: CustomTabContainer(
                isSelected: selectedIndex == index,
                text: tab.text,
                icon: tab.icon,
                borderRadius: tabBorderRadius,
                onTap: () => onTabSelected(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class TabItem {
  final String text;
  final Widget? icon;

  TabItem({required this.text, this.icon});
}
