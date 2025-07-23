import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/delivery/features/home/domain/usecases/new_order_usecase%20.dart';
import 'package:x_go/delivery/features/home/presentation/logic/new_order_cubit/new_order_state.dart';

/// NewOrdersCubit is responsible for managing the state of new orders.
class NewOrdersCubit extends Cubit<NewOrderStatusState> {
  final GetNewOrdersUseCase _getNewOrdersUseCase;

  NewOrdersCubit(this._getNewOrdersUseCase)
    : super(const NewOrderStatusState.initial());

  Future<void> fetchNewOrders() async {
    emit(const NewOrderStatusState.loading());
    final result = await _getNewOrdersUseCase(NoParams());
    emit(
      result.fold(
        (failure) => NewOrderStatusState.error(failure.message),
        (newOrders) => NewOrderStatusState.success(newOrders),
      ),
    );
  }
}
