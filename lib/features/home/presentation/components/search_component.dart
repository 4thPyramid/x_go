import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/filter/presentation/views/filter_view.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search your cars',
        prefixIcon: Icon(Icons.search),
        suffixIcon: Builder(
  builder: (context) {
    return IconButton(
      onPressed: () {
          final homeCubit = context.read<HomeCubit>();  // جلب من السياق الصحيح هنا

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return BlocProvider.value(
              value: homeCubit,
              child: const FilterView(),
            );
          },
        );
      },
      icon: Icon(Icons.filter_alt_outlined),
    );
  },
),
      ),
    );
  }
}
