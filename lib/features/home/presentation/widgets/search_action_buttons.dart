import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/home/presentation/components/SearchManager.dart';
import 'clear_search_button.dart';
import 'filter_button.dart';

class SearchActionButtons extends StatelessWidget {
  final SearchManager searchManager;

  const SearchActionButtons({
    super.key,
    required this.searchManager,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: searchManager,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (searchManager.hasText)
              ClearSearchButton(onPressed: searchManager.clearSearch),
            SizedBox(width: 4.w),
            FilterButton(onPressed: searchManager.openFilter),
          ],
        );
      },
    );
  }
}
