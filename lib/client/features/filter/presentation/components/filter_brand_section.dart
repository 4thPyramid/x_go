// filter_brand_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/client/features/home/presentation/logic/cubit/home_cubit/home_state.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';
import '../widgets/brand_selector.dart';
import 'filter_loading_widget.dart';
import 'filter_error_widget.dart';

class FilterBrandSection extends StatelessWidget {
  final HomeState state;
  final List<Brand> cachedBrands;
  final bool hasLoadedData;
  final String? selectedBrand;
  final Function(String?) onBrandSelected;

  const FilterBrandSection({
    super.key,
    required this.state,
    required this.cachedBrands,
    required this.hasLoadedData,
    required this.selectedBrand,
    required this.onBrandSelected,
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

    // عرض Brand Selector مع البيانات المُحملة
    return BrandSelector(
      brands: cachedBrands,
      selectedBrand: selectedBrand,
      onBrandSelected: (brand) {
        onBrandSelected(selectedBrand == brand ? null : brand);
      },
    );
  }

  /// دالة مساعدة لاستخراج رسالة الخطأ بأمان
  String _getErrorMessage(HomeState state) {
    if (state is HomeError) {
      return 'خطأ في تحميل الماركات: ${state.message}';
    }
    return 'خطأ في تحميل الماركات: خطأ غير معروف';
  }
}
