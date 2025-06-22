import 'package:flutter/material.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search your cars',
        prefixIcon: Icon(Icons.search),
        suffixIcon: Icon(Icons.filter_alt_outlined),
      ),
    );
  }
}
