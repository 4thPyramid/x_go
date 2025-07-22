import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/delivery/features/home/domain/usecases/accepted_order_usecase.dart';
import 'package:x_go/delivery/features/home/presentation/logic/accepted_status_cubit/accepted_order_state.dart';

///
class AcceptedOrdersCubit extends Cubit<AcceptedStatusState> {
  final GetAcceptedOrdersUseCase _getAcceptedOrdersUseCase;
  //final GetNewOrdersUseCase _getNewOrdersUseCase;

  AcceptedOrdersCubit(this._getAcceptedOrdersUseCase)
    : super(const AcceptedStatusState.acceptedOrderInitial());

  Future<void> fetchAcceptedOrders() async {
    emit(const AcceptedStatusState.acceptedOrderLoading());
    final result = await _getAcceptedOrdersUseCase(NoParams());
    emit(
      result.fold(
        (failure) => AcceptedStatusState.acceptedError(failure.message),
        (acceptedOrders) =>
            AcceptedStatusState.acceptedOrderSuccess(acceptedOrders),
      ),
    );
  }
}
