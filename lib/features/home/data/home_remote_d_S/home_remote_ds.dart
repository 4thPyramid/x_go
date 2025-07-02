import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/core/data/api/dio_consumer.dart';
import 'package:x_go/features/home/data/models/home_model.dart';

abstract class HomeRemoteDs {

  Future <List<CarModel>> getHomeData(
    double? minPrice,
  double? maxPrice,
  String? brandId,
  String? typeId,
  );
}
class HomeRemoteDsImpl implements HomeRemoteDs {
final ApiConsumer apiConsumer ;

  HomeRemoteDsImpl(this.apiConsumer);

  @override
 @override
Future<List<CarModel>> getHomeData(
  double? minPrice,
  double? maxPrice,
  String? brandId,
  String? typeId,
) async {
  final response = await apiConsumer.post(
    EndpointsStrings.home,
    data: {
      if (minPrice != null) 'min_price': minPrice,
      if (maxPrice != null) 'max_price': maxPrice,
      if (brandId != null) 'brand_id': brandId,
      if (typeId != null) 'type_id': typeId,
    },
    
    isFormData: true,
  );

  return List<CarModel>.from(
    (response['data'] as List).map((e) => CarModel.fromJson(e)),
  );
}

  }

