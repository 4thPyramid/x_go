import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/review/data/model/car_details_model.dart';

abstract class ReviewRemoteDataSource {
  Future<Either<ErrorModel, CarDetailsModel>> getReviews(int id);
  Future<Either<ErrorModel, void>> addReview(
    int modelId,
    String review,
    int rating,
  );
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final ApiConsumer apiConsumer;

  ReviewRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<Either<ErrorModel, CarDetailsModel>> getReviews(int id) async {
    try {
      var response = await apiConsumer.get('Model/$id');
      final data = response['data'];
      final x = CarDetailsModel.fromJson(data);
      return Right(x);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, void>> addReview(
    int modelId,
    String review,
    int rating,
  ) async {
    try {
      var response = await apiConsumer.post(
        'Model/$modelId/rate',
        data: {'review': review, 'rating': rating},
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    }
  }
}
