import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/features/carBooking/data/data_source/remote_data_source.dart';
import 'package:x_go/features/carBooking/data/model/book_car_model.dart';
import 'package:x_go/features/carBooking/data/model/locations_model.dart';
import 'package:x_go/features/carBooking/data/repositories/car_booking_repo_impl.dart';
import 'package:x_go/features/carBooking/domain/use_cases/book_car_use_case.dart';
import 'package:x_go/features/carBooking/domain/use_cases/get_locations_use_case.dart';
import 'package:x_go/features/location/domain/use_cases/set_location_use_case.dart';
import 'package:x_go/features/splash/views/splash_view.dart';

part 'car_booking_state.dart';

class CarBookingCubit extends Cubit<CarBookingState> {
  CarBookingCubit() : super(CarBookingInitial());

  Future<void> bookCar(
    String carId,
    String startDate,
    String endDate,
    String isAdditionalDriverChecked,
    String locationId,
    String modelId,
  ) async {
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
        locationId: locationId,
        modelId: modelId,
      );
      result.fold((l) => emit(CarBookingError(l.message)), (r) {
        emit(CarBookingSuccess(r));
      });
    } catch (e, trace) {
      print('========================');
      print(e.toString());
      print('========================');
      print(trace.toString());
      emit(CarBookingError(e.toString()));
    }
  }

  getAllLocations() async {
    emit(GetLocationLoading());
    final useCase = GetLocationsUseCase(
      CarBookingRepoImpl(
        CarBookingRemoteDataSourceImpl(DioConsumer(dio: Dio())),
      ),
    );
    try {
      final result = await useCase.call();
      result.fold((l) => emit(GetLocationError(l.message)), (r) {
        emit(GetLocationSuccess(r));
      });
    } catch (e) {
      emit(GetLocationError(e.toString()));
    }
  }
}
