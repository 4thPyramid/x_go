// year_dropdown.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

class YearDropdown extends StatefulWidget {
  final List<String> years;
  final String? selectedYear;
  final Function(String?) onYearSelected;

  const YearDropdown({
    super.key,
    required this.years,
    required this.selectedYear,
    required this.onYearSelected,
  });

  @override
  State<YearDropdown> createState() => _YearDropdownState();
}

class _YearDropdownState extends State<YearDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.years.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        _buildHeader(),

        SizedBox(height: 16.h),

        // Year Selection
        _buildYearSelector(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.calendar_today_rounded,
            size: 20.r,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'Select Year',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
        ),
        if (widget.selectedYear != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              widget.selectedYear!,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildYearSelector() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: _isExpanded || widget.selectedYear != null
              ? AppColors.primaryColor
              : AppColors.lightBorderGrey,
          width: _isExpanded || widget.selectedYear != null ? 2.0 : 1.0,
        ),
        color: widget.selectedYear != null
            ? AppColors.primaryColor.withOpacity(0.05)
            : AppColors.white,
        boxShadow: [
          if (_isExpanded || widget.selectedYear != null)
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          else
            BoxShadow(
              color: AppColors.shadow.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: AppColors.primaryColor.withOpacity(0.1),
          highlightColor: AppColors.primaryColor.withOpacity(0.05),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: widget.selectedYear,
            onTap: () => setState(() => _isExpanded = true),
            onChanged: (value) {
              setState(() => _isExpanded = false);
              widget.onYearSelected(value);
            },
            hint: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  Icon(
                    Icons.event_available_rounded,
                    size: 20.r,
                    color: AppColors.textMuted,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Choose year',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            selectedItemBuilder: (context) {
              return _buildAllItems().map((item) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        widget.selectedYear == null
                            ? Icons.select_all_rounded
                            : Icons.event_rounded,
                        size: 20.r,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        widget.selectedYear ?? 'All Years',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
            items: _buildDropdownItems(),
            icon: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: AnimatedRotation(
                turns: _isExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 24.r,
                  color: widget.selectedYear != null
                      ? AppColors.primaryColor
                      : AppColors.textMuted,
                ),
              ),
            ),
            dropdownColor: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            elevation: 8,
            menuMaxHeight: 300.h,
          ),
        ),
      ),
    );
  }

  List<String?> _buildAllItems() {
    return [null, ...widget.years];
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return [
      // All Years Option
      DropdownMenuItem<String>(
        value: null,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.cancel_rounded,
                  size: 16.r,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'All Years',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (widget.selectedYear == null)
                Icon(
                  Icons.check_circle_rounded,
                  size: 20.r,
                  color: AppColors.primaryColor,
                ),
            ],
          ),
        ),
      ),

      // Individual Years
      ...widget.years.map((year) {
        final isSelected = widget.selectedYear == year;
        final currentYear = DateTime.now().year;
        final yearInt = int.tryParse(year) ?? currentYear;
        final isRecent = currentYear - yearInt <= 3;

        return DropdownMenuItem<String>(
          value: year,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: isRecent
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.lightGrey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    isRecent ? Icons.new_releases_rounded : Icons.event_rounded,
                    size: 16.r,
                    color: isRecent
                        ? AppColors.success
                        : AppColors.textSecondary,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    year,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                if (isRecent)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'NEW',
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                SizedBox(width: 8.w),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    size: 20.r,
                    color: AppColors.primaryColor,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    ];
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.lightBorderGrey),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.event_busy_rounded,
              size: 40.r,
              color: AppColors.textMuted,
            ),
            SizedBox(height: 12.h),
            Text(
              'No years available',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              'Year data will be loaded shortly',
              style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
