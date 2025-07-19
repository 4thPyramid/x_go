// features/home/presentation/components/search_component.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/client/features/home/data/models/filter_info_model.dart';
import 'package:x_go/client/features/home/presentation/components/SearchManager.dart';
import 'package:x_go/client/features/home/presentation/components/search_container.dart';
import 'package:x_go/client/features/home/presentation/widgets/filter_modal_helper.dart';
import '../logic/cubit/home_cubit/home_cubit.dart';
import '../logic/cubit/home_cubit/home_state.dart';

class SearchComponent extends StatefulWidget {
  final Function(HomeRequestParams)? onParamsChanged;

  const SearchComponent({super.key, this.onParamsChanged});

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  late final SearchManager _searchManager;

  @override
  void initState() {
    super.initState();
    _searchManager = SearchManager(
      onSearchChanged: _handleSearchChanged,
      onSearchSubmitted: _handleSearchSubmitted,
      onSearchCleared: _handleSearchCleared,
      onFilterTapped: _handleFilterTapped,
    );
  }

  @override
  void dispose() {
    _searchManager.dispose();
    super.dispose();
  }

  void _handleSearchChanged(String query) {
    if (query.trim().isEmpty) {
      context.read<HomeCubit>().getCars();
      widget.onParamsChanged?.call(HomeRequestParams(page: 1));
    } else if (query.trim().length >= 1) {
      context.read<HomeCubit>().searchCars(query.trim());
      widget.onParamsChanged?.call(
        HomeRequestParams(search: query.trim(), page: 1),
      );
    }
  }

  void _handleSearchSubmitted(String query) {
    if (query.trim().isNotEmpty && query.trim().length >= 2) {
      context.read<HomeCubit>().searchCars(query.trim());
      widget.onParamsChanged?.call(
        HomeRequestParams(search: query.trim(), page: 1),
      );
      FocusScope.of(context).unfocus();
    }
  }

  void _handleSearchCleared() {
    context.read<HomeCubit>().getCars();
    widget.onParamsChanged?.call(HomeRequestParams(page: 1));
    FocusScope.of(context).unfocus();
  }

  void _handleFilterTapped() {
    FilterModalManager.show(
      context: context,
      onFilterApplied: widget.onParamsChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        _searchManager.handleStateChange(state);
      },
      child: SearchContainer(searchManager: _searchManager),
    );
  }
}
