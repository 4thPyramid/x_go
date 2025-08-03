import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ChangeStatsResponse extends Equatable {
  final bool success;
  final String message;
  final dynamic data;

  const ChangeStatsResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ChangeStatsResponse.fromJson(Map<String, dynamic> json) {
    return ChangeStatsResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }

  @override
  List<Object?> get props => [success, message, data];
}
