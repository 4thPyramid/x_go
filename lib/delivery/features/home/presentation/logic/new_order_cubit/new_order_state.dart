// accepted_order_state.dart
// This file defines the AcceptedOrdersState class, which represents the various states of accepted orders in the application.
// It uses the Freezed package for immutability and pattern matching.
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';

part 'new_order_state.freezed.dart';

@freezed
class NewOrderStatusState with _$NewOrderStatusState {
  const factory NewOrderStatusState.initial() = _newOrderInitial;
  const factory NewOrderStatusState.loading() = _newOrderLoading;
  const factory NewOrderStatusState.success(List<OrderStatusEntity> orders) =
      _newOrderSuccess;
  const factory NewOrderStatusState.error(String message) = _newOrderError;
}
