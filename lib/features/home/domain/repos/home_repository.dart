import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/features/home/data/home_remote_d_S/home_remote_ds.dart';
import 'package:x_go/features/home/data/models/home_model.dart';

class HomeRepository {
  final HomeRemoteDs homeRemoteDs;

  HomeRepository(this.homeRemoteDs);
  Future<Either<ErrorModel, List <CarModel>>> getHomeData(
     double? minPrice,
  double? maxPrice,
  String? brandId,
  String? typeId,
   ) async {
    try {
      final response = await homeRemoteDs.getHomeData(
       minPrice,
         maxPrice,
        brandId,
       typeId,

      );
      return Right(response);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}