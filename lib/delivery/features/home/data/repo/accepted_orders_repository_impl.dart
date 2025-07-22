// accepted_orders_repository_impl.dart
// This file implements the AcceptedOrdersRepository interface, providing methods to fetch accepted orders.

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/delivery/features/home/data/data_sources/accepted_oreders_ds.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';
import 'package:x_go/delivery/features/home/domain/repos/accepted_orders_repository.dart';

class AcceptedOrdersRepositoryImpl implements AcceptedOrdersRepository {
  final AcceptedOrdersDataSource dataSource;

  AcceptedOrdersRepositoryImpl({required this.dataSource});

  @override
  Future<Either<ErrorModel, List<AcceptedOrderEntity>>>
  getAcceptedOrders() async {
    try {
      final response = await dataSource.getAcceptedOrders();
      final orders = response.data
          .map((acceptedOrder) => acceptedOrder.toEntity())
          .toList();
      return Right(orders);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
