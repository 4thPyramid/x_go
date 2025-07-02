import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';

abstract class ProfileRemoteDs {
  Future<Map<String, dynamic>> updateProfileData(
    String name,
    String lastName,
    String image,
    String email,
    String phone,
    
    );
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
}