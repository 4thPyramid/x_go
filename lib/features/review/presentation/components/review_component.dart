import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/review/presentation/logic/cubit/review_cubit.dart';

class ReviewComponent extends StatelessWidget {
  const ReviewComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is AddReviewError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is AddReviewSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.success)));
        }
      },
      builder: (context, state) {
        return state is GetReviewLoading
            ? const Center(child: CircularProgressIndicator())
            : state is GetReviewSuccess
            ? Expanded(
                child: state.reviews.relationship.ratings.reviews.isEmpty
                    ? Expanded(child: Center(child: Text('No Reviews Yet')))
                    : ListView.builder(
                        itemCount:
                            state.reviews.relationship.ratings.reviews.length,
                        itemBuilder: (context, index) {
                          final review =
                              state.reviews.relationship.ratings.reviews[index];

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${review.userName} ${review.lastName}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (i) => Icon(
                                            i < review.rating
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: Colors.amber,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),

                                  Text(
                                    review.email,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  Text(
                                    review.review.replaceAll('"', ''),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              )
            : state is GetReviewError
            ? Center(child: Text(state.error))
            : const SizedBox.shrink();
      },
    );
  }
}
