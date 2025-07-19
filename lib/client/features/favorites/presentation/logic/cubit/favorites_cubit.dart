import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/client/features/favorites/data/models/favorite_model.dart';
import 'package:x_go/client/features/favorites/data/repositories/favorites_repository.dart';
import 'package:x_go/client/features/favorites/presentation/logic/cubit/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository favoritesRepository;
  List<String> _favoriteCarIds = [];

  FavoritesCubit({required this.favoritesRepository})
    : super(FavoritesInitial());

  Future<void> getFavorites() async {
    emit(FavoritesLoading());
    try {
      final favorites = await favoritesRepository.getFavorites();
      _favoriteCarIds = favorites.map((fav) => fav.carModel.id).toList();
      emit(FavoritesLoaded(favorites: favorites));
    } catch (error) {
      emit(FavoritesError(message: error.toString()));
    }
  }

  Future<void> toggleFavorite(String carId) async {
    try {
      // Handle optimistic update in favorites view
      if (state is FavoritesLoaded) {
        final currentFavorites = List<FavoriteModel>.from(
          (state as FavoritesLoaded).favorites,
        );

        if (_favoriteCarIds.contains(carId)) {
          // Remove from local list
          _favoriteCarIds.remove(carId);

          // Remove from UI list immediately
          currentFavorites.removeWhere((fav) => fav.carModel.id == carId);
          emit(FavoritesLoaded(favorites: currentFavorites));
        } else {
          // Add to local list
          _favoriteCarIds.add(carId);
          emit(FavoritesLoaded(favorites: currentFavorites));
        }
      }

      // Update on server in background
      await favoritesRepository.toggleFavorite(carId);

      // Only refresh if we're adding to favorites, not if removing
      // This way items disappear immediately on removal
      if (!_favoriteCarIds.contains(carId)) {
        // We've removed the item, no need to refresh
      } else {
        // We've added an item, refresh to get the full details
        await getFavorites();
      }
    } catch (error) {
      // Rollback on error
      await getFavorites();
      emit(FavoritesError(message: error.toString()));
    }
  }

  // Method to check if a car is in favorites
  bool isFavorite(String carId) {
    return _favoriteCarIds.contains(carId);
  }
}
