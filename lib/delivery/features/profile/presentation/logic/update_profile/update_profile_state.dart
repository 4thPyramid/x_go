import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_update_entity.dart';

part 'update_profile_state.freezed.dart';

@freezed
abstract class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState.initial() = _Initial;

  const factory UpdateProfileState.loading() = _Loading;

  const factory UpdateProfileState.success({
    required String message,
    required DriverUpdateEntity driverUpdateEntity,
  }) = _Success;

  const factory UpdateProfileState.error({required String message}) = _Error;
}
