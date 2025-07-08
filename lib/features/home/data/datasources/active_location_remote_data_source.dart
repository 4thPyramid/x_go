import 'package:x_go/core/data/api/api_consumer.dart';

import '../models/location_model.dart';

abstract class ActiveLocationRemoteDataSource {
  Future<ActiveLocationResponse> getActiveLocation();
}

class ActiveLocationRemoteDataSourceImpl implements ActiveLocationRemoteDataSource {
  final ApiConsumer apiConsumer;

  ActiveLocationRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ActiveLocationResponse> getActiveLocation() async {
    final response = await apiConsumer.get('active-locations');
    return ActiveLocationResponse.fromJson(response);
  }
}
