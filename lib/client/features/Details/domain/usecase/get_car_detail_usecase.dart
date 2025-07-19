// features/Details/domain/usecase/get_car_detail_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:x_go/core/utils/faluire.dart';
import 'package:x_go/client/features/Details/data/models/car_detail_model.dart';
import 'package:x_go/client/features/Details/domain/repo/car_detail_repository.dart';

class GetCarDetailUseCase {
  final CarDetailRepository repository;

  GetCarDetailUseCase({required this.repository});

  Future<Either<Failure, CarDetailResponse>> call(String id) async {
    return await repository.getCarDetail(id);
  }
}
