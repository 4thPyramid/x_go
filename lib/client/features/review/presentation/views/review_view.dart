import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/client/features/review/presentation/components/add_review_component.dart';
import 'package:x_go/client/features/review/presentation/components/review_component.dart';
import 'package:x_go/client/features/review/presentation/logic/cubit/review_cubit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
