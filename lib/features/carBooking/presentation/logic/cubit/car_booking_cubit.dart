import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/features/carBooking/data/data_source/remote_data_source.dart';
import 'package:x_go/features/carBooking/data/repositories/car_booking_repo_impl.dart';
import 'package:x_go/features/carBooking/domain/use_cases/book_car_use_case.dart';
import 'package:x_go/features/carBooking/domain/use_cases/set_location_use_case.dart';

part 'car_booking_state.dart';

class CarBookingCubit extends Cubit<CarBookingState> {
  CarBookingCubit() : super(CarBookingInitial());

  setLocation() {
    final useCase = SetLocationUseCase(
      CarBookingRepoImpl(
        CarBookingRemoteDataSourceImpl(DioConsumer(dio: Dio())),
      ),
    );
    emit(SetLocationLoading());
    useCase
        .call(latitude: '30.0', longitude: '30.0', location: 'Cairo')
        .then((value) {
          emit(SetLocationSuccess());
        })
        .catchError((error) {
          emit(SetLocationError(error.toString()));
        });
  }

  bookCar() {
    final useCase = BookCarUseCase(
      CarBookingRepoImpl(
        CarBookingRemoteDataSourceImpl(DioConsumer(dio: Dio())),
      ),
    );
    emit(CarBookingLoading());
    useCase
        .call(carId: '1', startDate: '2025-07-02', endDate: '2025-07-02')
        .then((value) {
          emit(CarBookingSuccess());
        })
        .catchError((error) {
          emit(CarBookingError(error.toString()));
        });
  }
}
