// filter_type_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/client/features/filter/presentation/widgets/CarTypeSelector.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_state.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';
import 'filter_loading_widget.dart';
import 'filter_error_widget.dart';

class FilterTypeSection extends StatefulWidget {
  final HomeState state;
  final List<CarType> cachedTypes;
  final bool hasLoadedData;
  final String? selectedType;
  final Function(String?) onTypeSelected;

  const FilterTypeSection({
    super.key,
    required this.state,
    required this.cachedTypes,
    required this.hasLoadedData,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  State<FilterTypeSection> createState() => _FilterTypeSectionState();
}

class _FilterTypeSectionState extends State<FilterTypeSection> {
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

    // تحويل CarType إلى List<String> للاستخدام في CarTypeSelector
    final types = widget.cachedTypes.map((type) => type.name).toList();

    // عرض Car Type Selector مع البيانات المُحملة
    return CarTypeSelector(
      types: types,
      selectedType: widget.selectedType,
      onTypeSelected: (type) {
        if (mounted) {
          widget.onTypeSelected(widget.selectedType == type ? null : type);
        }
      },
    );
  }

  /// دالة مساعدة لاستخراج رسالة الخطأ بأمان
  String _getErrorMessage(HomeState state) {
    if (state is HomeError) {
      return 'خطأ في تحميل أنواع السيارات: ${state.message}';
    }
    return 'خطأ في تحميل أنواع السيارات: خطأ غير معروف';
  }
}
