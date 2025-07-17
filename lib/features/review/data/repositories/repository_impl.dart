import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/review/data/data_source/remote_data_source.dart';
import 'package:x_go/features/review/data/model/car_details_model.dart';
import 'package:x_go/features/review/domain/repositories/review_repo.dart';

class ReviewRepositoryImpl implements ReviewRepo {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<ErrorModel, CarDetailsModel>> getReviews(int id) {
    return remoteDataSource.getReviews(id);
  }

  @override
  Future<Either<ErrorModel, void>> addReview(
    int modelId,
    String review,
    int rating,
  ) {
    return remoteDataSource.addReview(modelId, review, rating);
  }
}
