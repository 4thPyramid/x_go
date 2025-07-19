import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/client/features/review/data/data_source/remote_data_source.dart';
import 'package:x_go/client/features/review/data/model/car_details_model.dart';

class GetReviewUseCase {
  final ReviewRemoteDataSource remoteDataSource;

  GetReviewUseCase({required this.remoteDataSource});

  Future<Either<ErrorModel, CarDetailsModel>> call(int id) async {
    return await remoteDataSource.getReviews(id);
  }
}
