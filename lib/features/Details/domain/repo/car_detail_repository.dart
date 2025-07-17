// features/Details/domain/repo/car_detail_repository.dart
import 'package:dartz/dartz.dart';
import 'package:x_go/core/utils/faluire.dart';
import 'package:x_go/features/Details/data/models/car_detail_model.dart';

abstract class CarDetailRepository {
  Future<Either<Failure, CarDetailResponse>> getCarDetail(String id);
}
