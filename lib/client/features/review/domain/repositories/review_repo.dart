import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/review/data/model/car_details_model.dart';

abstract class ReviewRepo {
  Future<Either<ErrorModel, CarDetailsModel>> getReviews(int id);
  Future<Either<ErrorModel, void>> addReview(
    int modelId,
    String review,
    int rating,
  );
}
