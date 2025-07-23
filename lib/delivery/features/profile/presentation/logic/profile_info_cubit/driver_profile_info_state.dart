import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';

part 'driver_profile_info_state.freezed.dart';

@freezed
class DriverProfileInfoState with _$DriverProfileInfoState {
  const factory DriverProfileInfoState.initial() = _Initial;
  const factory DriverProfileInfoState.loading() = _Loading;
  const factory DriverProfileInfoState.success(
    DriverProfileEntity driverProfile,
  ) = _Success;
  const factory DriverProfileInfoState.error(String message) = _Error;
}
