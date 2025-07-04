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

  Future<void> bookCar(
    String carId,
    String startDate,
    String endDate,
    String isAdditionalDriverChecked, {
    String? lat,
    String? long,
    String? location,
  }) async {
    emit(CarBookingLoading());

    final useCase = BookCarUseCase(
      CarBookingRepoImpl(
        CarBookingRemoteDataSourceImpl(DioConsumer(dio: Dio())),
      ),
    );
    try {
      final result = await useCase.call(
        carId: carId,
        startDate: startDate,
        endDate: endDate,
        isAdditionalDriverChecked: isAdditionalDriverChecked,
        lat: lat!,
        long: long!,
        location: location!,
      );
      result.fold((l) => emit(CarBookingError(l.message)), (r) {
        emit(CarBookingSuccess());
      });
    } catch (e) {
      print('========================');
      print(e.toString());
      emit(CarBookingError(e.toString()));
    }
  }
}
