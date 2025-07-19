// features/home/presentation/widgets/search_container.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/client/features/home/presentation/components/SearchManager.dart';
import 'package:x_go/client/features/home/presentation/widgets/search_action_buttons.dart';
import 'package:x_go/client/features/home/presentation/widgets/search_loading_indicaror.dart';
import 'search_input_field.dart';

class SearchContainer extends StatelessWidget {
  final SearchManager searchManager;

  const SearchContainer({super.key, required this.searchManager});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SearchLoadingIndicator(),
          SizedBox(width: 12.w),
          Expanded(child: SearchInputField(searchManager: searchManager)),
          SearchActionButtons(searchManager: searchManager),
        ],
      ),
    );
  }
}
