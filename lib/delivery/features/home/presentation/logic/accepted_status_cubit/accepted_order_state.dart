// accepted_order_state.dart
// This file defines the AcceptedOrdersState class, which represents the various states of accepted orders in the application.
// It uses the Freezed package for immutability and pattern matching.
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';

part 'accepted_order_state.freezed.dart';

@freezed
class AcceptedStatusState with _$AcceptedStatusState {
  const factory AcceptedStatusState.acceptedOrderInitial() =
      _acceptedOrderInitial;
  const factory AcceptedStatusState.acceptedOrderLoading() =
      _acceptedOrderLoading;
  const factory AcceptedStatusState.acceptedOrderSuccess(
    List<OrderStatusEntity> orders,
  ) = _acceptedOrderSuccess;
  const factory AcceptedStatusState.acceptedError(String message) =
      _acceptedError;
}
