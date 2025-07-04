import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/features/filter/presentation/views/filter_view.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_cubit.dart';
import 'package:x_go/features/home/presentation/logic/cubit/home_state.dart';

class SearchComponent extends StatefulWidget {
  const SearchComponent({super.key});

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CarCubit, CarState>(
      listener: (context, state) {
        if (state is CarsLoaded && (state.searchQuery?.isEmpty ?? true)) {
          if (_searchController.text.isNotEmpty) {
            _searchController.clear();
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey[600], size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'search Car',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (query) {
                  context.read<CarCubit>().searchCars(query);
                },
              ),
            ),
            if (_searchController.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  _searchController.clear();
                  context.read<CarCubit>().searchCars('');
                },
              ),
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.orange),
              onPressed: () => _showFilterModal(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => BlocProvider.value(
        value: BlocProvider.of<CarCubit>(context, listen: false),
        child: Container(
          height: MediaQuery.of(modalContext).size.height * .9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: const FilterView(),
        ),
      ),
    ).then((result) {
      context.read<CarCubit>().refresh();
    });
  }
}