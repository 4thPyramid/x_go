import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/delivery/features/home/domain/usecases/completed_order_usecase.dart';
import 'package:x_go/delivery/features/home/presentation/logic/completed_status_cubit/completed_order_state.dart';

/// NewOrdersCubit is responsible for managing the state of new orders.
class CompletedOrdersCubit extends Cubit<CompletedOrderStatusState> {
  final GetCompletedOrdersUseCase _getCompletedOrdersUseCase;

  CompletedOrdersCubit(this._getCompletedOrdersUseCase)
    : super(const CompletedOrderStatusState.initial());

  Future<void> fetchCompletedOrders() async {
    emit(const CompletedOrderStatusState.loading());
    final result = await _getCompletedOrdersUseCase(NoParams());
    emit(
      result.fold(
        (failure) => CompletedOrderStatusState.error(failure.message),
        (completedOrders) {
          return CompletedOrderStatusState.success(completedOrders);
        },
      ),
    );
  }
}
