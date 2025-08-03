import 'package:hive_flutter/hive_flutter.dart';
import 'package:x_go/client/features/favorites/data/models/favorite_model.dart';
import 'package:x_go/core/services/hive_manager.dart';

/// Abstract interface for favorites local data operations
abstract class FavoritesLocalDataSource {
  Future<void> cacheFavorites(List<FavoriteModel> favorites);
  Future<List<FavoriteModel>> getCachedFavorites();
  Future<void> addToFavorites(FavoriteModel favorite);
  Future<void> removeFromFavorites(String favoriteId);
  Future<bool> isFavorite(String carId);
  Future<void> clearFavorites();
  Future<int> getFavoritesCount();
  Future<bool> isCacheExpired(Duration maxAge);
}

/// Implementation of [FavoritesLocalDataSource] using Hive
class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String _favoritesKey = 'cached_favorites';
  static const String _timestampKey = 'favorites_timestamp';

  /// Get the favorites box from HiveManager
  Box get _box => HiveManager.getFavoritesBox();

  @override
  Future<void> cacheFavorites(List<FavoriteModel> favorites) async {
    try {
      // Convert to JSON and save
      final favoritesJson = favorites.map((e) => e.toJson()).toList();
      await _box.put(_favoritesKey, favoritesJson);
      await _box.put(_timestampKey, DateTime.now().millisecondsSinceEpoch);

      // Force sync to disk
      await _box.flush();

      print('💾 Cached ${favorites.length} favorites and synced to disk');
    } catch (e) {
      print('❌ Error caching favorites: $e');
      rethrow;
    }
  }

  @override
  Future<List<FavoriteModel>> getCachedFavorites() async {
    try {
      final data = _box.get(_favoritesKey);
      if (data != null && data is List && data.isNotEmpty) {
        final favorites = data
            .map((item) {
              try {
                return FavoriteModel.fromJson(Map<String, dynamic>.from(item));
              } catch (e) {
                print(' Error parsing favorite item: $e');
                return null;
              }
            })
            .where((item) => item != null)
            .cast<FavoriteModel>()
            .toList();
        return favorites;
      } else {
        print(' No cached favorites found or empty cache');
        return [];
      }
    } catch (e) {
      print(' Error getting cached favorites: $e');
      return []; // Return empty list instead of throwing
    }
  }

  @override
  Future<void> addToFavorites(FavoriteModel favorite) async {
    try {
      final currentFavorites = await getCachedFavorites();

      // Check if already exists
      final existingIndex = currentFavorites.indexWhere(
        (f) => f.carModel.id == favorite.carModel.id,
      );

      if (existingIndex == -1) {
        currentFavorites.add(favorite);
        await cacheFavorites(currentFavorites);
      } else {
        print(' Already in favorites: ${favorite.carModel.id}');
      }
    } catch (e) {
      print(' Error adding to favorites: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeFromFavorites(String favoriteId) async {
    try {
      final currentFavorites = await getCachedFavorites();
      final updatedFavorites = currentFavorites
          .where((f) => f.carModel.id != favoriteId)
          .toList();

      if (updatedFavorites.length != currentFavorites.length) {
        await cacheFavorites(updatedFavorites);
        print(' Removed from favorites: $favoriteId');
      } else {
        print(' Not found in favorites: $favoriteId');
      }
    } catch (e) {
      print(' Error removing from favorites: $e');
      rethrow;
    }
  }

  @override
  Future<bool> isFavorite(String carId) async {
    try {
      final favorites = await getCachedFavorites();
      final isFav = favorites.any((f) => f.carModel.id == carId);
      print('🔍 Is favorite ($carId): $isFav');
      return isFav;
    } catch (e) {
      print(' Error checking favorite status: $e');
      return false;
    }
  }

  @override
  Future<void> clearFavorites() async {
    try {
      await _box.delete(_favoritesKey);
      await _box.delete(_timestampKey);
      await _box.flush(); // Force sync to disk
    } catch (e) {
      print(' Error clearing favorites: $e');
      rethrow;
    }
  }

  @override
  Future<int> getFavoritesCount() async {
    try {
      final favorites = await getCachedFavorites();
      final count = favorites.length;
      print(' Favorites count: $count');
      return count;
    } catch (e) {
      print(' Error getting favorites count: $e');
      return 0;
    }
  }

  /// Get the timestamp when favorites were last cached
  Future<DateTime?> getLastCacheTime() async {
    try {
      final timestamp = _box.get(_timestampKey) as int?;
      if (timestamp != null) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      }
      return null;
    } catch (e) {
      print('❌ Error getting cache timestamp: $e');
      return null;
    }
  }

  /// Check if cache is older than specified duration
  @override
  Future<bool> isCacheExpired(Duration maxAge) async {
    try {
      final lastCacheTime = await getLastCacheTime();
      if (lastCacheTime == null) return true;

      final now = DateTime.now();
      return now.difference(lastCacheTime) > maxAge;
    } catch (e) {
      print('❌ Error checking cache expiry: $e');
      return true;
    }
  }
}
