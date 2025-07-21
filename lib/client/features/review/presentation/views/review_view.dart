import 'package:flutter/material.dart';

import 'package:x_go/client/features/review/presentation/components/add_review_component.dart';
import 'package:x_go/client/features/review/presentation/components/review_component.dart';

class ReviewView extends StatelessWidget {
  final int id;
  const ReviewView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Column(
        children: [
          ReviewComponent(),
          AddReviewComponent(id: id),
        ],
      ),
    );
  }
}
