import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';

part 'completed_order_state.freezed.dart';

@freezed
class CompletedOrderStatusState with _$CompletedOrderStatusState {
  const factory CompletedOrderStatusState.initial() = _completedOrderInitial;
  const factory CompletedOrderStatusState.loading() = _completedOrderLoading;
  const factory CompletedOrderStatusState.success(
    List<OrderStatusEntity> orders,
  ) = _completedOrderSuccess;
  const factory CompletedOrderStatusState.error(String message) =
      _completedOrderError;
  const factory CompletedOrderStatusState.empty() = _Empty;
}
