// custom_order_card.dart
//this is a AcceptedOrdersDataSource implementation that fetches accepted orders from the API.
import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/delivery/features/home/data/model/order_status_model_response.dart';

abstract class OrdersStatusDataSource {
  Future<OrderStatusResponse> getAcceptedOrders();
  Future<OrderStatusResponse> getNewOrders();
  Future<OrderStatusResponse> getCompletedOrders();
}

class OrdersStatusDataSourceImpl implements OrdersStatusDataSource {
  final ApiConsumer apiConsumer;

  OrdersStatusDataSourceImpl({required this.apiConsumer});

  @override
  Future<OrderStatusResponse> getAcceptedOrders() async {
    final acceptedOrderResponse = await apiConsumer.get(
      EndpointsStrings.acceptedOrders,
    );
    return OrderStatusResponse.fromJson(acceptedOrderResponse);
  }

  @override
  Future<OrderStatusResponse> getNewOrders() async {
    final newOrderResponse = await apiConsumer.get(EndpointsStrings.newOrders);
    return OrderStatusResponse.fromJson(newOrderResponse);
  }

  @override
  Future<OrderStatusResponse> getCompletedOrders() async {
    final completedOrderResponse = await apiConsumer.get(
      EndpointsStrings.completedOrders,
    );
    return OrderStatusResponse.fromJson(completedOrderResponse);
  }
}
