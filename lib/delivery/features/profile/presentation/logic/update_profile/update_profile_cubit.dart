import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/delivery/features/profile/data/models/driver_update_request.dart';
import 'package:x_go/delivery/features/profile/domain/entities/driver_profile_entity.dart';
import 'package:x_go/delivery/features/profile/domain/usecase/driver_update_use_case.dart';
import 'package:x_go/delivery/features/profile/presentation/logic/update_profile/update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final DriverUpdateUseCase driverUpdateUseCase;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  bool isLoading = false;
  late String originalName;
  late String originalEmail;
  late String originalPhone;

  UpdateProfileCubit(this.driverUpdateUseCase)
    : super(const UpdateProfileState.initial());

  Future<void> updateProfile(DriverUpdateRequest request) async {
    emit(const UpdateProfileState.loading());

    final result = await driverUpdateUseCase(request);

    result.fold(
      (error) => emit(UpdateProfileState.error(message: error.message)),
      (data) => emit(
        UpdateProfileState.success(
          message: "تم التحديث بنجاح", // Updated to match API response
          driverUpdateEntity: data,
        ),
      ),
    );
  }

  void populateFields(DriverProfileEntity entity) {
    originalName = entity.name ?? '';
    originalEmail = entity.email ?? '';
    originalPhone = entity.phone ?? '';
    nameController.text = originalName;
    emailController.text = originalEmail;
    phoneController.text = originalPhone;
  }
}
