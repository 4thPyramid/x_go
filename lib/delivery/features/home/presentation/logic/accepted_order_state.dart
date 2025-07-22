// accepted_order_state.dart
// This file defines the AcceptedOrdersState class, which represents the various states of accepted orders in the application.
// It uses the Freezed package for immutability and pattern matching.
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';

part 'accepted_order_state.freezed.dart';

@freezed
class AcceptedOrdersState with _$AcceptedOrdersState {
  const factory AcceptedOrdersState.initial() = _Initial;
  const factory AcceptedOrdersState.loading() = _Loading;
  const factory AcceptedOrdersState.success(List<AcceptedOrderEntity> orders) =
      _Success;
  const factory AcceptedOrdersState.error(String message) = _Error;
}
