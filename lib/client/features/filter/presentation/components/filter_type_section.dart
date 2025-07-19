// filter_type_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/client/features/filter/presentation/widgets/CarTypeSelector.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_state.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';
import 'filter_loading_widget.dart';
import 'filter_error_widget.dart';

class FilterTypeSection extends StatelessWidget {
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

    // تحويل CarType إلى List<String> للاستخدام في CarTypeSelector
    final types = cachedTypes.map((type) => type.name).toList();

    // عرض Car Type Selector مع البيانات المُحملة
    return CarTypeSelector(
      types: types,
      selectedType: selectedType,
      onTypeSelected: (type) {
        onTypeSelected(selectedType == type ? null : type);
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
