import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/features/carBooking/data/data_source/remote_data_source.dart';
import 'package:x_go/features/carBooking/data/repositories/car_booking_repo_impl.dart';
import 'package:x_go/features/carBooking/domain/use_cases/book_car_use_case.dart';
import 'package:x_go/features/location/domain/use_cases/set_location_use_case.dart';

part 'car_booking_state.dart';

class CarBookingCubit extends Cubit<CarBookingState> {
  CarBookingCubit() : super(CarBookingInitial());

  bookCar(String carId, String startDate, String endDate) {
    final useCase = BookCarUseCase(
      CarBookingRepoImpl(
        CarBookingRemoteDataSourceImpl(DioConsumer(dio: Dio())),
      ),
    );
    emit(CarBookingLoading());
    try {
      useCase.call(carId: carId, startDate: startDate, endDate: endDate);
      emit(CarBookingSuccess());
    } catch (e) {
      emit(CarBookingError(e.toString()));
    }
  }
}
