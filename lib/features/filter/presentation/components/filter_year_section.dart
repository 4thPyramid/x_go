// filter_year_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_state.dart';
import '../widgets/year_dropdown.dart';
import 'filter_loading_widget.dart';
import 'filter_error_widget.dart';

class FilterYearSection extends StatelessWidget {
  final HomeState state;
  final List<String> cachedYears;
  final bool hasLoadedData;
  final String? selectedYear;
  final Function(String?) onYearSelected;

  const FilterYearSection({
    super.key,
    required this.state,
    required this.cachedYears,
    required this.hasLoadedData,
    required this.selectedYear,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    // عرض Loading أثناء تحميل البيانات لأول مرة
    if (state is FilterLoading && !hasLoadedData) {
      return const FilterLoadingWidget();
    }

    // عرض Error إذا فشل التحميل
    if (state is HomeError && !hasLoadedData) {
      return FilterErrorWidget(
        message: _getErrorMessage(state),
        onRetry: () => context.read<HomeCubit>().getFilterInfo(),
      );
    }

    // عرض Year Dropdown مع البيانات المُحملة
    return YearDropdown(
      years: cachedYears,
      selectedYear: selectedYear,
      onYearSelected: (year) {
        onYearSelected(selectedYear == year ? null : year);
      },
    );
  }

  /// دالة مساعدة لاستخراج رسالة الخطأ بأمان
  String _getErrorMessage(HomeState state) {
    if (state is HomeError) {
      return 'خطأ في تحميل السنوات: ${state.message}';
    }
    return 'خطأ في تحميل السنوات: خطأ غير معروف';
  }
}
