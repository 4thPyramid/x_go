// features/Details/data/repo/car_detail_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/core/utils/faluire.dart';
import 'package:x_go/client/features/Details/data/datasources/car_detail_remote_data_source.dart';
import 'package:x_go/client/features/Details/data/models/car_detail_model.dart';
import 'package:x_go/client/features/Details/domain/repo/car_detail_repository.dart';

class CarDetailRepositoryImpl implements CarDetailRepository {
  final CarDetailRemoteDataSource remoteDataSource;

  CarDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CarDetailResponse>> getCarDetail(String id) async {
    try {
      final result = await remoteDataSource.getCarDetail(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.message));
    }
  }
}
