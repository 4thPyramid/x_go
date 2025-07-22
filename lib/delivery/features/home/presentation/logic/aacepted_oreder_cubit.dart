import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/utils/use_case.dart';
import 'package:x_go/delivery/features/home/domain/usecases/accepted_order_usecase.dart';
import 'package:x_go/delivery/features/home/presentation/logic/accepted_order_state.dart';

/// Cubit responsible for managing the state of accepted orders.
///
/// This cubit handles fetching accepted orders data and emitting appropriate states
/// based on the result of the fetch operation.
class AcceptedOrdersCubit extends Cubit<AcceptedOrdersState> {
  final GetAcceptedOrdersUseCase _getAcceptedOrdersUseCase;

  /// Creates an instance of [AcceptedOrdersCubit].
  ///
  /// Requires an instance of [GetAcceptedOrdersUseCase] to fetch the accepted orders.
  AcceptedOrdersCubit(this._getAcceptedOrdersUseCase)
    : super(const AcceptedOrdersState.initial());

  /// Fetches the list of accepted orders.
  ///
  /// Emits a loading state while fetching the data, and then either a success state
  /// with the fetched orders or an error state with the error message.
  Future<void> fetchAcceptedOrders() async {
    emit(const AcceptedOrdersState.loading());
    final result = await _getAcceptedOrdersUseCase(NoParams());
    emit(
      result.fold(
        (failure) => AcceptedOrdersState.error(failure.message),
        (orders) => AcceptedOrdersState.success(orders),
      ),
    );
  }
}
