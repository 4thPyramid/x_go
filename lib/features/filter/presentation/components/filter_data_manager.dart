// filter_data_manager.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/car_entity.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit/home_state.dart';

class FilterDataManager extends StatelessWidget {
  final Function(List<Brand>, List<CarType>, bool) onDataLoaded;
  final Widget child;

  const FilterDataManager({
    super.key,
    required this.onDataLoaded,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is FilterInfoLoaded) {
          onDataLoaded(
            state.filterInfo.brands,
            state.filterInfo.types,
            true,
          );
        }
      },
      builder: (context, state) {
        return child;
      },
    );
  }
}
