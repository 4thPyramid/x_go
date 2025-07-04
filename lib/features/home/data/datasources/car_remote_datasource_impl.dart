import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/features/home/data/datasources/car_remote_datasource.dart';
import 'package:x_go/features/home/data/models/cars_response_model.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/filter_request_entity.dart';

class CarRemoteDatasourceImpl implements CarRemoteDatasource {
  final ApiConsumer apiConsumer;

  CarRemoteDatasourceImpl({required this.apiConsumer});

  @override
  Future<CarsResponseModel> getCars(FilterRequestEntity? filterRequest) async {
    final Map<String, dynamic> data = {};

    if (filterRequest != null) {
      if (filterRequest.brand != null) data['brand'] = filterRequest.brand;
      if (filterRequest.type != null) data['type'] = filterRequest.type;
      if (filterRequest.model != null) data['model'] = filterRequest.model;
      if (filterRequest.minPrice != null) data['min_price'] = filterRequest.minPrice;
      if (filterRequest.maxPrice != null) data['max_price'] = filterRequest.maxPrice;
    }

    final response = await apiConsumer.post(
      'https://xgo.ibrahimbashaa.com/api/user/Home',
      data: data,
    );

    return CarsResponseModel.fromJson(response);
  }

  @override
  Future<FilterInfoModel> getFilterInfo() async {
    final response = await apiConsumer.get('https://xgo.ibrahimbashaa.com/api/user/filter-Info',);
    return FilterInfoModel.fromJson(response);
  }
}
