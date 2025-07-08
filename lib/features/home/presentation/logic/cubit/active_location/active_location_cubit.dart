import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/features/home/domain/usecase/get_active_location_usecase.dart';
import 'package:x_go/features/home/domain/usecase/get_filter_info_usecase.dart';
import 'package:x_go/features/home/presentation/logic/cubit/active_location/active_location_state.dart';

class ActiveLocationCubit extends Cubit<ActiveLocationState> {
  final GetActiveLocationUseCase getActiveLocationUseCase;

  ActiveLocationCubit({required this.getActiveLocationUseCase}) : super(ActiveLocationInitial());

  Future<void> getActiveLocation() async {
    emit(ActiveLocationLoading());

    final result = await getActiveLocationUseCase(NoParams());

    result.fold(
          (failure) => emit(ActiveLocationError(message: failure.message)),
          (location) => emit(ActiveLocationLoaded(activeLocation: location)),
    );
  }
}
