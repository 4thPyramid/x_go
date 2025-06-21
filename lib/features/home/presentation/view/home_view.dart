import 'package:flutter/material.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                Text('Cairo,Egypt'),
                CircleAvatar(),
              ],
            ),
            CustomTextFormField(labelText: 'Search'),
            Row(
              children: [
                Text('Popular'),
                Spacer(),
                TextButton(onPressed: () {}, child: Text('View all')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
