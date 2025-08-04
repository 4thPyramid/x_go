// filter_year_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_state.dart';
import '../widgets/year_dropdown.dart';
import 'filter_loading_widget.dart';
import 'filter_error_widget.dart';

class FilterYearSection extends StatefulWidget {
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
  State<FilterYearSection> createState() => _FilterYearSectionState();
}

class _FilterYearSectionState extends State<FilterYearSection> {
  HomeCubit? _homeCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // حفظ مرجع آمن للـ HomeCubit
    _homeCubit ??= context.read<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    // عرض Loading أثناء تحميل البيانات لأول مرة
    if (widget.state is FilterLoading && !widget.hasLoadedData) {
      return const FilterLoadingWidget();
    }

    // عرض Error إذا فشل التحميل
    if (widget.state is HomeError && !widget.hasLoadedData) {
      return FilterErrorWidget(
        message: _getErrorMessage(widget.state),
        onRetry: () {
          // استخدام المرجع المحفوظ بدلاً من context.read
          if (_homeCubit != null && mounted) {
            _homeCubit!.getFilterInfo();
          }
        },
      );
    }

    // عرض Year Dropdown مع البيانات المُحملة
    return YearDropdown(
      years: widget.cachedYears,
      selectedYear: widget.selectedYear,
      onYearSelected: (year) {
        if (mounted) {
          widget.onYearSelected(widget.selectedYear == year ? null : year);
        }
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
