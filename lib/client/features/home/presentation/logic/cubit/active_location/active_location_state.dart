// features/location/presentation/logic/cubit/location_state.dart
import 'package:equatable/equatable.dart';
import 'package:x_go/client/features/home/domain/entity/active_location.dart';

abstract class ActiveLocationState extends Equatable {
  const ActiveLocationState();

  @override
  List<Object> get props => [];
}

class ActiveLocationInitial extends ActiveLocationState {}

class ActiveLocationLoading extends ActiveLocationState {}

class ActiveLocationLoaded extends ActiveLocationState {
  final LocationActive activeLocation;

  const ActiveLocationLoaded({required this.activeLocation});

  @override
  List<Object> get props => [activeLocation];
}

class ActiveLocationError extends ActiveLocationState {
  final String message;

  const ActiveLocationError({required this.message});

  @override
  List<Object> get props => [message];
}
