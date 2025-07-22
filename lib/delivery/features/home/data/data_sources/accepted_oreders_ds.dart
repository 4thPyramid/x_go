// custom_order_card.dart
//this is a AcceptedOrdersDataSource implementation that fetches accepted orders from the API.
import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/delivery/features/home/data/model/accepted_order_response_model.dart';

abstract class AcceptedOrdersDataSource {
  Future<AcceptedOrderResponse> getAcceptedOrders();
}

class AcceptedOrdersDataSourceImpl implements AcceptedOrdersDataSource {
  final ApiConsumer apiConsumer;

  AcceptedOrdersDataSourceImpl({required this.apiConsumer});

  @override
  Future<AcceptedOrderResponse> getAcceptedOrders() async {
    final acceptedOrderResponse = await apiConsumer.get(
      EndpointsStrings.acceptedOrders,
    );
    return AcceptedOrderResponse.fromJson(acceptedOrderResponse);
  }
}
