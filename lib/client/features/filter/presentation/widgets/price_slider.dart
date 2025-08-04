import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/theme/app_colors.dart';

class PriceSlider extends StatefulWidget {
  final RangeValues rangeValues;
  final ValueChanged<RangeValues> onChanged;
  final double minPrice;
  final double maxPrice;
  final bool isLoading; // ✅ إضافة loading state

  const PriceSlider({
    super.key,
    required this.rangeValues,
    required this.onChanged,
    this.minPrice = 2000,
    this.maxPrice = 9000,
    this.isLoading = false, // ✅ قيمة افتراضية
  });

  @override
  State<PriceSlider> createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  @override
  Widget build(BuildContext context) {
    // ✅ عرض loading state إذا كانت البيانات قيد التحميل
    if (widget.isLoading) {
      return _buildLoadingState();
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.lightBorderGrey),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _buildHeader(),

          SizedBox(height: 20.h),

          // Price Range Display
          _buildPriceRangeDisplay(),

          SizedBox(height: 16.h),

          // Bar Chart
          _buildPriceChart(),

          SizedBox(height: 16.h),

          // Range Slider
          _buildRangeSlider(),

          SizedBox(height: 12.h),

          // Price Labels
          _buildPriceLabels(),
        ],
      ),
    );
  }

  // ✅ إضافة loading state للـ price slider
  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.lightBorderGrey),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildHeader(),
          SizedBox(height: 20.h),

          // Loading Container
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Loading price range...',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
            Icons.attach_money_rounded,
            size: 20.r,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price Range',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              // ✅ إضافة مؤشر أن البيانات من الـ API
              if (!widget.isLoading)
                Text(
                  'Live market data',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    letterSpacing: 0.2,
                  ),
                ),
            ],
          ),
        ),
        // ✅ أيقونة تشير لمصدر البيانات
        if (!widget.isLoading)
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.cloud_done_rounded,
              size: 14.r,
              color: AppColors.success,
            ),
          ),
      ],
    );
  }

  Widget _buildPriceRangeDisplay() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPriceItem(
            label: 'Min Price',
            price: widget.rangeValues.start,
            icon: Icons.keyboard_arrow_down_rounded,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'TO',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                letterSpacing: 1,
              ),
            ),
          ),
          _buildPriceItem(
            label: 'Max Price',
            price: widget.rangeValues.end,
            icon: Icons.keyboard_arrow_up_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceItem({
    required String label,
    required double price,
    required IconData icon,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(icon, size: 16.r, color: AppColors.primaryColor),
            SizedBox(width: 4.w),
            Text(
              '\$${_formatPrice(price)}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceChart() {
    return Container(
      height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          barGroups: _buildBarGroups(),
          maxY: 10,
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(12, (i) {
      final stepSize = (widget.maxPrice - widget.minPrice) / 12;
      final barValue = widget.minPrice + (i * stepSize);
      final isInRange =
          barValue >= widget.rangeValues.start &&
          barValue <= widget.rangeValues.end;

      // Create varying heights for more realistic distribution
      final height = 3 + (i % 3) + (i % 2) * 2.0;

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: height,
            width: 8.w,
            borderRadius: BorderRadius.circular(4.r),
            color: isInRange
                ? AppColors.primaryColor
                : AppColors.lightGrey.withOpacity(0.6),
            gradient: isInRange
                ? LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withOpacity(0.7),
                    ],
                  )
                : null,
          ),
        ],
      );
    });
  }

  Widget _buildRangeSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 6.h,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.r),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 20.r),
        activeTrackColor: AppColors.primaryColor,
        inactiveTrackColor: AppColors.lightGrey.withOpacity(0.5),
        thumbColor: AppColors.white,
        overlayColor: AppColors.primaryColor.withOpacity(0.1),
        rangeThumbShape: RoundRangeSliderThumbShape(
          enabledThumbRadius: 12.r,
          elevation: 4,
        ),
        rangeTrackShape: RoundedRectRangeSliderTrackShape(),
        rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
        valueIndicatorColor: AppColors.primaryColor,
        valueIndicatorTextStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: RangeSlider(
        values: widget.rangeValues,
        min: widget.minPrice,
        max: widget.maxPrice,
        divisions: 50,
        labels: RangeLabels(
          '\$${_formatPrice(widget.rangeValues.start)}',
          '\$${_formatPrice(widget.rangeValues.end)}',
        ),
        onChanged: widget.onChanged,
      ),
    );
  }

  Widget _buildPriceLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPriceLabel('\$${_formatPrice(widget.minPrice)}', 'Min'),
        _buildPriceLabel(
          '\$${_formatPrice((widget.minPrice + widget.maxPrice) / 2)}',
          'Avg',
        ),
        _buildPriceLabel('\$${_formatPrice(widget.maxPrice)}', 'Max'),
      ],
    );
  }

  Widget _buildPriceLabel(String price, String label) {
    return Column(
      children: [
        Text(
          price,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(price % 1000 == 0 ? 0 : 1)}K';
    }
    return price.toStringAsFixed(0);
  }
}
