import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/client/features/review/data/data_source/remote_data_source.dart';
import 'package:x_go/client/features/review/data/model/car_details_model.dart';
import 'package:x_go/client/features/review/domain/use_case/add_review_use_case.dart';
import 'package:x_go/client/features/review/domain/use_case/get_review_use_cas.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  Future<void> getReviews(int id) async {
    final getReviewsUseCase = GetReviewUseCase(
      remoteDataSource: ReviewRemoteDataSourceImpl(DioConsumer(dio: Dio())),
    );
    emit(GetReviewLoading());
    final result = await getReviewsUseCase.call(id);
    result.fold(
      (error) => emit(GetReviewError(error.message)),
      (success) => emit(GetReviewSuccess(success)),
    );
  }

  Future<void> addReview(int modelId, String review, int rating) async {
    final addReviewUseCase = AddReviewUseCase(
      remoteDataSource: ReviewRemoteDataSourceImpl(DioConsumer(dio: Dio())),
    );
    emit(AddReviewLoading());
    final result = await addReviewUseCase.call(modelId, review, rating);
    result.fold(
      (error) => emit(AddReviewError(error.message)),
      (success) => emit(AddReviewSuccess('Review added successfully')),
    );
  }
}
