import 'package:x_go/client/features/favorites/data/local_ds/favorites_local_ds.dart';
import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/client/features/favorites/data/models/favorite_model.dart';

/// Repository for managing favorites with cache-first strategy
class FavoritesRepository {
  final ApiConsumer apiConsumer;
  final FavoritesLocalDataSource favLocalDataSource;

  // Cache configuration
  static const Duration _cacheMaxAge = Duration(hours: 24);

  FavoritesRepository(this.favLocalDataSource, {required this.apiConsumer});

  /// Get favorites with cache-first strategy
  Future<List<FavoriteModel>> getFavorites({bool forceRefresh = false}) async {
    try {
      // 1. Check if we should use cache first
      if (!forceRefresh) {
        final isExpired = await favLocalDataSource.isCacheExpired(_cacheMaxAge);

        if (!isExpired) {
          final cachedFavorites = await favLocalDataSource.getCachedFavorites();
          if (cachedFavorites.isNotEmpty) {
            // Optionally update cache in background
            _updateCacheInBackground();
            return cachedFavorites;
          }
        }
      }

      // 2. Fetch from API
      final response = await apiConsumer.get(EndpointsStrings.favorites);
      final favorites = (response as List)
          .map((favorite) => FavoriteModel.fromJson(favorite))
          .toList();

      // 3. Cache the fresh data
      await favLocalDataSource.cacheFavorites(favorites);

      return favorites;
    } catch (e) {
      // 4. Fallback to cache if API fails
      try {
        final cachedFavorites = await favLocalDataSource.getCachedFavorites();

        return cachedFavorites;
      } catch (cacheError) {
        return []; // Return empty list if both API and cache fail
      }
    }
  }

  /// Toggle favorite status and update cache
  Future<String> toggleFavorite(String carId) async {
    try {
      final response = await apiConsumer.post(
        '${EndpointsStrings.favoritesToggle}/$carId',
      );

      // Update local cache after successful toggle
      await _updateLocalCacheAfterToggle(carId);

      return response['message'];
    } catch (e) {
      rethrow;
    }
  }

  /// Add specific car to favorites
  Future<void> addToFavorites(FavoriteModel favorite) async {
    await favLocalDataSource.addToFavorites(favorite);
  }

  /// Remove specific car from favorites
  Future<void> removeFromFavorites(String carId) async {
    await favLocalDataSource.removeFromFavorites(carId);
  }

  /// Check if car is in favorites
  Future<bool> isFavorite(String carId) async {
    return await favLocalDataSource.isFavorite(carId);
  }

  /// Get favorites count
  Future<int> getFavoritesCount() async {
    return await favLocalDataSource.getFavoritesCount();
  }

  /// Clear all favorites
  Future<void> clearAllFavorites() async {
    await favLocalDataSource.clearFavorites();
  }

  /// Update cache in background without blocking UI
  void _updateCacheInBackground() {
    Future.microtask(() async {
      try {
        final response = await apiConsumer.get(EndpointsStrings.favorites);
        final favorites = (response as List)
            .map((favorite) => FavoriteModel.fromJson(favorite))
            .toList();

        await favLocalDataSource.cacheFavorites(favorites);
      } catch (e) {
        // Fail silently in background
      }
    });
  }

  /// Update local cache after toggle operation
  Future<void> _updateLocalCacheAfterToggle(String carId) async {
    try {
      // Check current status
      final isFav = await favLocalDataSource.isFavorite(carId);

      if (isFav) {
        // If it was favorite, remove it
        await favLocalDataSource.removeFromFavorites(carId);
      } else {
        // If it wasn't favorite, we'd need the full car data to add
        // For now, we'll refresh the whole cache
        await getFavorites(forceRefresh: true);
      }
    } catch (e) {
      // Don't throw - this is just cache management
    }
  }
}
