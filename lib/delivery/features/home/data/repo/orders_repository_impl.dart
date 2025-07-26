// accepted_orders_repository_impl.dart
// This file implements the AcceptedOrdersRepository interface, providing methods to fetch accepted orders.

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/delivery/features/home/data/data_sources/oreders_status_ds.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';
import 'package:x_go/delivery/features/home/domain/repos/orders_repository.dart';

class OrdersStatusRepositoryImpl implements OrdersStatusRepository {
  final OrdersStatusDataSource dataSource;

  OrdersStatusRepositoryImpl({required this.dataSource});

  @override
  Future<Either<ErrorModel, List<OrderStatusEntity>>>
  getAcceptedOrders() async {
    try {
      final response = await dataSource.getAcceptedOrders();
      final orders = response.data!
          .map((acceptedOrder) => acceptedOrder.toEntity())
          .toList();
      return Right(orders);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<OrderStatusEntity>>> getNewOrders() async {
    try {
      final response = await dataSource.getNewOrders();
      final orders = response.data!
          .map((newOrders) => newOrders.toEntity())
          .toList();
      return Right(orders);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<OrderStatusEntity>>>
  getCompletedOrders() async {
    try {
      final response = await dataSource.getCompletedOrders();
      final orders = response.data!
          .map((completedOrders) => completedOrders.toEntity())
          .toList();
      return Right(orders);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }
}
