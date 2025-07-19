import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/client/features/review/presentation/logic/cubit/review_cubit.dart';

void showAddReviewSheet(BuildContext context, int id, ReviewCubit reviewCubit) {
  final TextEditingController reviewController = TextEditingController();
  double selectedRating = 1;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 24,
          left: 16,
          right: 16,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 80,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Add a Review',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // RatingBar
                Center(
                  child: RatingBar.builder(
                    initialRating: selectedRating,
                    minRating: 1,
                    itemSize: 36,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() {
                        selectedRating = rating;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),

                TextField(
                  controller: reviewController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Write your review...',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                BlocConsumer<ReviewCubit, ReviewState>(
                  bloc: reviewCubit,
                  listener: (context, state) {
                    if (state is AddReviewError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    } else if (state is AddReviewSuccess) {
                      reviewCubit.getReviews(id);

                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return Center(
                      child: state is AddReviewLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              onPressed: () {
                                reviewCubit.addReview(
                                  id,
                                  reviewController.text,
                                  selectedRating.toInt(),
                                );
                              },
                              text: 'Submit',
                            ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      );
    },
  );
}
