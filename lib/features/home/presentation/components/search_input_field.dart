// features/home/presentation/widgets/search_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/home/presentation/components/SearchManager.dart';

class SearchInputField extends StatelessWidget {
  final SearchManager searchManager;

  const SearchInputField({
    super.key,
    required this.searchManager,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchManager.controller,
      decoration: InputDecoration(
        hintText: 'Search for cars or brands...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 14.sp,
        ),
      ),
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.black87,
      ),
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      autocorrect: false,
      enableSuggestions: true,
      onSubmitted: (_) => searchManager.submitSearch(),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}
