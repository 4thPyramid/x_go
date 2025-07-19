// features/Details/presentation/logic/cubit/car_detail_state.dart
import 'package:equatable/equatable.dart';
import 'package:x_go/client/features/Details/data/models/car_detail_model.dart';

abstract class CarDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CarDetailInitial extends CarDetailState {}

class CarDetailLoading extends CarDetailState {}

class CarDetailLoaded extends CarDetailState {
  final CarDetailResponse carDetail;

  CarDetailLoaded({required this.carDetail});

  @override
  List<Object?> get props => [carDetail];
}

class CarDetailError extends CarDetailState {
  final String message;

  CarDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
