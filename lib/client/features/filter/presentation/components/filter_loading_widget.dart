// filter_loading_widget.dart
import 'package:flutter/material.dart';

class FilterLoadingWidget extends StatelessWidget {
  const FilterLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
