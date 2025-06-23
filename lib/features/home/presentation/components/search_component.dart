import 'package:flutter/material.dart';
import 'package:x_go/features/filter/presentation/views/filter_view.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search your cars',
        prefixIcon: Icon(Icons.search),
        suffixIcon: IconButton( onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // عشان يكون ارتفاعه قابل للتمرير والملء
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) {
                return const FilterView();
              },
            );
        }, icon:Icon (Icons.filter_alt_off_outlined)),
      ),
    );
  }
}
