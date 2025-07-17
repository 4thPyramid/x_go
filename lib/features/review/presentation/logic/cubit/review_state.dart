part of 'review_cubit.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {}

final class AddReviewLoading extends ReviewState {}

final class AddReviewSuccess extends ReviewState {
  final String success;

  const AddReviewSuccess(this.success);
}

final class AddReviewError extends ReviewState {
  final String error;

  const AddReviewError(this.error);
}

final class GetReviewSuccess extends ReviewState {
  final CarDetailsModel reviews;

  const GetReviewSuccess(this.reviews);
}

final class GetReviewError extends ReviewState {
  final String error;

  const GetReviewError(this.error);
}

final class GetReviewLoading extends ReviewState {}
