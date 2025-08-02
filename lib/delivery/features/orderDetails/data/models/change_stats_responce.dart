class StatsModel {
  final int id;
  final int carId;
  final int userId;
  final int driverId;
  final String startDate;
  final String endDate;
  final String finalPrice;
  final String status;
  final int additionalDriver;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? transactionId;
  final int carmodelId;
  final int? locationId;

  StatsModel({
    required this.id,
    required this.carId,
    required this.userId,
    required this.driverId,
    required this.startDate,
    required this.endDate,
    required this.finalPrice,
    required this.status,
    required this.additionalDriver,
    this.paymentMethod,
    this.paymentStatus,
    this.transactionId,
    required this.carmodelId,
    this.locationId,
  });

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      id: json['id'],
      carId: json['car_id'],
      userId: json['user_id'],
      driverId: json['driver_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      finalPrice: json['final_price'],
      status: json['status'],
      additionalDriver: json['additional_driver'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      transactionId: json['transaction_id'],
      carmodelId: json['carmodel_id'],
      locationId: json['location_id'],
    );
  }
}
class ChangeStatsResponse {
  final String message;
  final StatsModel data;

  ChangeStatsResponse({
    required this.message,
    required this.data,
  });

  factory ChangeStatsResponse.fromJson(Map<String, dynamic> json) {
    return ChangeStatsResponse(
      message: json['message'],
      data: StatsModel.fromJson(json['data']),
    );
  }
}
