// accepted_orders_repository.dart
// This repository interface defines the contract for fetching accepted orders.
import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';

abstract class AcceptedOrdersRepository {
  Future<Either<ErrorModel, List<AcceptedOrderEntity>>> getAcceptedOrders();
}
