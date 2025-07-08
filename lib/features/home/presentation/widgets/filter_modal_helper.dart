import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/filter/presentation/views/filter_view.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import '../logic/cubit/home_cubit/home_cubit.dart';

class FilterModalManager {
  static void show({
    required BuildContext context,
    Function(HomeRequestParams)? onFilterApplied,
  }) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (modalContext) => BlocProvider.value(
        value: BlocProvider.of<HomeCubit>(context, listen: false),
        child: Container(
          height: MediaQuery.of(modalContext).size.height * 0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: FilterView(
            onFilterApplied: (params) {
              onFilterApplied?.call(params);
            },
          ),
        ),
      ),
    ).then((_) {
    });
  }
}
