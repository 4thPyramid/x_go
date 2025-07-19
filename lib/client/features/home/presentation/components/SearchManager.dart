import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../logic/cubit/home_cubit/home_state.dart';

class SearchManager extends ChangeNotifier with WidgetsBindingObserver {
  final TextEditingController _searchController = TextEditingController();
  final Function(String) onSearchChanged;
  final Function(String) onSearchSubmitted;
  final VoidCallback onSearchCleared;
  final VoidCallback onFilterTapped;

  String _lastSearchQuery = '';
  String _lastSubmittedQuery = '';
  Timer? _debounceTimer;
  bool _isComposing = false;

  SearchManager({
    required this.onSearchChanged,
    required this.onSearchSubmitted,
    required this.onSearchCleared,
    required this.onFilterTapped,
  }) {
    WidgetsBinding.instance.addObserver(this);
    _searchController.addListener(_onTextChanged);
  }

  TextEditingController get controller => _searchController;
  bool get hasText => _searchController.text.isNotEmpty;
  bool get isComposing => _isComposing;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _debounceTimer?.cancel();
    }
  }

  void _onTextChanged() {
    final query = _searchController.text;

    if (_isComposing) {
      return;
    }

    notifyListeners();
    _handleSearchChanged(query);
  }

  void _handleSearchChanged(String query) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
      final trimmedQuery = query.trim().toLowerCase();

      if (trimmedQuery != _lastSearchQuery) {
        _lastSearchQuery = trimmedQuery;

        if (trimmedQuery.isEmpty) {
          onSearchChanged('');
        } else if (trimmedQuery.length >= 1) {
          onSearchChanged(trimmedQuery);
        } else {
          print('⚠️ Query too short (${trimmedQuery.length} chars), ignoring');
        }
      } else {
        print(
          '⏭️ SearchManager: Duplicate search prevented for "$trimmedQuery"',
        );
      }
    });
  }

  void submitSearch() {
    _debounceTimer?.cancel();

    final trimmedQuery = _searchController.text.trim().toLowerCase();

    if (trimmedQuery != _lastSubmittedQuery &&
        trimmedQuery.isNotEmpty &&
        trimmedQuery.length >= 2) {
      _lastSubmittedQuery = trimmedQuery;
      _lastSearchQuery = trimmedQuery;

      onSearchSubmitted(trimmedQuery);
    } else {
      print('⏭️ SearchManager: Duplicate submit prevented for "$trimmedQuery"');
    }
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    _searchController.clear();
    _lastSearchQuery = '';
    _lastSubmittedQuery = '';
    onSearchCleared();
    notifyListeners();
  }

  void openFilter() {
    onFilterTapped();
  }

  void handleStateChange(HomeState state) {
    // Only clear search if we explicitly got cars without any search params
    // Don't clear if it's an empty result with search params (no results found)
    if (state is CarsLoaded &&
        (state.currentParams.search?.isEmpty ?? true) &&
        state.cars.isNotEmpty) {
      if (_searchController.text.isNotEmpty) {
        _searchController.clear();
        _lastSearchQuery = '';
        _lastSubmittedQuery = '';
        notifyListeners();
      }
    }
    // If it's CarsLoaded with search params but empty cars, keep the search text
    // If it's an error state, also keep the search text
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _searchController.removeListener(_onTextChanged);
    _searchController.dispose();
    super.dispose();
  }
}
