import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/review/data/data_source/remote_data_source.dart';

class AddReviewUseCase {
  final ReviewRemoteDataSource remoteDataSource;

  AddReviewUseCase({required this.remoteDataSource});

  Future<Either<ErrorModel, void>> call(
    int modelId,
    String review,
    int rating,
  ) {
    return remoteDataSource.addReview(modelId, review, rating);
  }
}
