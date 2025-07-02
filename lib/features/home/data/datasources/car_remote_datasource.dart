import 'package:x_go/features/home/data/models/cars_response_model.dart';
import 'package:x_go/features/home/data/models/filter_info_model.dart';
import 'package:x_go/features/home/domain/entity/filter_request_entity.dart';

abstract class CarRemoteDatasource {
  Future<CarsResponseModel> getCars(FilterRequestEntity? filterRequest);
  Future<FilterInfoModel> getFilterInfo();
}