// accepted_order_usecase.dart
// This file defines the GetAcceptedOrdersUseCase class, which is responsible for fetching accepted orders.
// It uses the AcceptedOrdersRepository to retrieve the data and returns it wrapped in an Either type for error handling.
import 'package:dartz/dartz.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';
import 'package:x_go/delivery/features/home/domain/repos/accepted_orders_repository.dart';

class GetCompletedOrdersUseCase
    implements UseCase<List<OrderStatusEntity>, NoParams> {
  final OrdersStatusRepository _repository;

  GetCompletedOrdersUseCase(this._repository);
  @override
  Future<Either<ErrorModel, List<OrderStatusEntity>>> call(
    NoParams params,
  ) async {
    return await _repository.getCompletedOrders();
  }
}
