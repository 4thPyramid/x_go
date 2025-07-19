import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/client/features/review/presentation/logic/cubit/review_cubit.dart';
import 'package:x_go/client/features/review/presentation/views/review_view.dart';
import 'package:x_go/client/features/review/presentation/widgets/show_modal_bottom_sheet.dart';

class AddReviewComponent extends StatelessWidget {
  const AddReviewComponent({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              state is AddReviewLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      onPressed: () {
                        showAddReviewSheet(
                          context,
                          id,
                          context.read<ReviewCubit>(),
                        );
                      },
                      text: 'Add Review',
                    ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
