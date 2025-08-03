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

  /// Get the underlying box for advanced operations (if needed)
  Box getBox();
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
    } catch (e) {
      print(' Error caching favorites: $e');
      rethrow;
    }
  }

  @override
  Future<List<FavoriteModel>> getCachedFavorites() async {
    try {
      final data = _box.get(_favoritesKey);
      print('🔍 Raw cache data: $data');

      if (data != null && data is List && data.isNotEmpty) {
        final favorites = data
            .map((item) {
              try {
                print('🔧 Processing item type: ${item.runtimeType}');

                // Use deep conversion for all nested maps
                Map<String, dynamic> jsonMap = _deepConvertMap(item);

                return FavoriteModel.fromJson(jsonMap);
              } catch (e) {
                print(' Item: $item');
                return null;
              }
            })
            .where((item) => item != null)
            .cast<FavoriteModel>()
            .toList();

        return favorites;
      } else {
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
      print(' Error getting cache timestamp: $e');
      return null;
    }
  }

  /// Get the underlying box for advanced operations
  @override
  Box getBox() => _box;

  /// Check if cache is older than specified duration
  @override
  Future<bool> isCacheExpired(Duration maxAge) async {
    try {
      final lastCacheTime = await getLastCacheTime();
      if (lastCacheTime == null) return true;

      final now = DateTime.now();
      return now.difference(lastCacheTime) > maxAge;
    } catch (e) {
      print(' Error checking cache expiry: $e');
      return true;
    }
  }

  /// Deep convert any nested Map to Map<String, dynamic>
  Map<String, dynamic> _deepConvertMap(dynamic item) {
    if (item is Map<String, dynamic>) {
      return item;
    } else if (item is Map) {
      final result = <String, dynamic>{};
      item.forEach((key, value) {
        final stringKey = key.toString();
        if (value is Map) {
          result[stringKey] = _deepConvertMap(value);
        } else if (value is List) {
          result[stringKey] = value.map((e) {
            if (e is Map) {
              return _deepConvertMap(e);
            }
            return e;
          }).toList();
        } else {
          result[stringKey] = value;
        }
      });
      return result;
    } else {
      throw ArgumentError('Expected Map, got ${item.runtimeType}');
    }
  }
}
