import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:x_go/features/home/data/models/home_model.dart';
import 'package:x_go/features/home/domain/repos/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  HomeCubit(this.homeRepository) : super(HomeInitial());

  Future<void> getHomeData( 
    double? minPrice,
  double? maxPrice,
  String? brandId,
  String? typeId,
  ) async {
    emit(HomeLoading());
    final result = await homeRepository.getHomeData(minPrice, maxPrice, brandId, typeId,);
    result.fold((error) => emit(
          HomeError( message:  error.message),
          ), (homeData) => emit(
          HomeLoaded( cars: homeData),
          ),

    );
  }
}
