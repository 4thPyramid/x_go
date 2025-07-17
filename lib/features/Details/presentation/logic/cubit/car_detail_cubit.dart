// features/Details/presentation/logic/cubit/car_detail_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/Details/domain/usecase/get_car_detail_usecase.dart';
import 'package:x_go/features/Details/presentation/logic/cubit/car_detail_state.dart';

class CarDetailCubit extends Cubit<CarDetailState> {
  final GetCarDetailUseCase getCarDetailUseCase;

  CarDetailCubit({required this.getCarDetailUseCase})
    : super(CarDetailInitial());

  Future<void> getCarDetail(String id) async {
    emit(CarDetailLoading());
    try {
      final result = await getCarDetailUseCase(id);
      result.fold(
        (failure) => emit(CarDetailError(message: failure.message)),
        (data) => emit(CarDetailLoaded(carDetail: data)),
      );
    } catch (e) {
      emit(CarDetailError(message: 'An error occurred: $e'));
    }
  }
}
