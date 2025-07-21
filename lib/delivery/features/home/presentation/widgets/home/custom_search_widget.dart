import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/core/theme/app_colors.dart';

class CustomSearchDeliveryApp extends StatefulWidget {
  const CustomSearchDeliveryApp({super.key});

  @override
  State<CustomSearchDeliveryApp> createState() =>
      _CustomSearchDeliveryAppState();
}

class _CustomSearchDeliveryAppState extends State<CustomSearchDeliveryApp> {
  final TextEditingController? _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Orders'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.w),
        child: Column(
          children: [
            CustomTextFormField(
              verticalPadding: 14.0.w,
              hintText: 'Search...',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a search term';
                }
                return null;
              },
              controller: _searchController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              fillColor: AppColors.white,
              prefixIcon: Icon(Icons.search, color: AppColors.grey),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: AppColors.grey),
                onPressed: () {
                  // Clear search field logic

                  _searchController?.clear();
                },
              ),
              onchanged: (value) {
                // Handle search input changes
              },
            ),
          ],
        ),
      ),
    );
  }
}
