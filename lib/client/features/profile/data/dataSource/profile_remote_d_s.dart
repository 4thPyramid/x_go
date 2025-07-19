import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/client/features/profile/data/models/profile_edit_model.dart';

abstract class ProfileRemoteDs {
  Future<Map<String, dynamic>> updateProfileData(
    String name,
    String lastName,
    String image,
    String email,
    String phone,
  );

  Future<GetProfileResponse> getProfileData();
}

class ProfileRemoteDsImpl implements ProfileRemoteDs {
  final ApiConsumer apiConsumer;

  ProfileRemoteDsImpl(this.apiConsumer);

  @override
  Future<Map<String, dynamic>> updateProfileData(
    String name,
    String lastName,
    String image,
    String email,
    String phone,
  ) async {
    final response = await apiConsumer.post(
      EndpointsStrings.updateProfile,
      data: {
        'name': name,
        'last_name': lastName,
        'image': image,
        'email': email,
        'phone': phone,
      },
      isFormData: true,
    );
    return response;
  }

  @override
  Future<GetProfileResponse> getProfileData() async {
    final response = await apiConsumer.get(EndpointsStrings.getProfile);
    return GetProfileResponse.fromJson(response);
  }
}
