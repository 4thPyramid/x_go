import 'package:x_go/core/data/cached/cache_helper.dart';
import 'package:x_go/client/features/home/data/models/Pagination_response_odel%20.dart';
import 'package:x_go/client/features/home/data/models/filter_info_model.dart';

/// Abstract interface for home local data operations
abstract class HomeLocalDataSource {
  Future<CarsPaginationResponse?> getCachedCars(String cacheKey);
  Future<void> cacheCars(String cacheKey, CarsPaginationResponse response);
  Future<FilterInfoResponse?> getCachedFilterInfo();
  Future<void> cacheFilterInfo(FilterInfoResponse filterInfo);
  Future<void> clearAllCache();
  Future<void> clearCarsCache();
  bool isCacheValid(String cacheKey, Duration maxAge);
}

/// Implementation of [HomeLocalDataSource] using SharedPreferences
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String _carsKeyPrefix = 'cached_cars_';
  static const String _filterInfoKey = 'cached_filter_info';
  static const String _timestampSuffix = '_timestamp';

  @override
  Future<CarsPaginationResponse?> getCachedCars(String cacheKey) async {
    try {
      final fullKey = _carsKeyPrefix + cacheKey;
      final jsonData = CacheHelper.getJson(key: fullKey);

      if (jsonData != null) {
        return CarsPaginationResponse.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      // If cache is corrupted, return null
      return null;
    }
  }

  @override
  Future<void> cacheCars(
    String cacheKey,
    CarsPaginationResponse response,
  ) async {
    try {
      final fullKey = _carsKeyPrefix + cacheKey;
      final timestampKey = fullKey + _timestampSuffix;

      // Save the response data
      await CacheHelper.saveJson(key: fullKey, json: response.toJson());

      // Save timestamp for cache validation
      await CacheHelper.saveData(
        key: timestampKey,
        value: DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      // Fail silently if caching fails
    }
  }

  @override
  Future<FilterInfoResponse?> getCachedFilterInfo() async {
    try {
      final jsonData = CacheHelper.getJson(key: _filterInfoKey);

      if (jsonData != null) {
        return FilterInfoResponse.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheFilterInfo(FilterInfoResponse filterInfo) async {
    try {
      final timestampKey = _filterInfoKey + _timestampSuffix;

      // Save the filter info
      await CacheHelper.saveJson(
        key: _filterInfoKey,
        json: filterInfo.toJson(),
      );

      // Save timestamp
      await CacheHelper.saveData(
        key: timestampKey,
        value: DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      // Fail silently if caching fails
    }
  }

  @override
  Future<void> clearAllCache() async {
    try {
      // Clear all cars cache
      await clearCarsCache();

      // Clear filter info cache
      await _removeData(_filterInfoKey);
      await _removeData(_filterInfoKey + _timestampSuffix);
    } catch (e) {
      // Fail silently
    }
  }

  @override
  Future<void> clearCarsCache() async {
    try {
      // Get all keys and find car cache keys
      final allKeys = CacheHelper.sharedPreferences.getKeys();
      final carCacheKeys = allKeys.where(
        (key) => key.startsWith(_carsKeyPrefix),
      );

      // Remove all car cache entries
      for (final key in carCacheKeys) {
        await _removeData(key);
      }
    } catch (e) {
      // Fail silently
    }
  }

  @override
  bool isCacheValid(String cacheKey, Duration maxAge) {
    try {
      final fullKey = cacheKey.startsWith(_carsKeyPrefix)
          ? cacheKey
          : cacheKey == 'filter_info'
          ? _filterInfoKey
          : _carsKeyPrefix + cacheKey;
      final timestampKey = fullKey + _timestampSuffix;

      final timestamp = CacheHelper.getData(key: timestampKey) as int?;

      if (timestamp == null) return false;

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();

      return now.difference(cacheTime) < maxAge;
    } catch (e) {
      return false;
    }
  }

  /// Helper method to remove data
  Future<void> _removeData(String key) async {
    try {
      await CacheHelper.sharedPreferences.remove(key);
    } catch (e) {
      // Fail silently
    }
  }

  /// Generate cache key based on request parameters
  static String generateCacheKey(HomeRequestParams params) {
    final keyParts = <String>[];

    if (params.search?.isNotEmpty == true) {
      keyParts.add('search_${params.search}');
    }
    if (params.brand?.isNotEmpty == true) {
      keyParts.add('brand_${params.brand}');
    }
    if (params.type?.isNotEmpty == true) {
      keyParts.add('type_${params.type}');
    }
    if (params.model?.isNotEmpty == true) {
      keyParts.add('model_${params.model}');
    }
    if (params.year?.isNotEmpty == true) {
      keyParts.add('year_${params.year}');
    }
    if (params.minPrice?.isNotEmpty == true) {
      keyParts.add('minPrice_${params.minPrice}');
    }
    if (params.maxPrice?.isNotEmpty == true) {
      keyParts.add('maxPrice_${params.maxPrice}');
    }
    if (params.engineType?.isNotEmpty == true) {
      keyParts.add('engineType_${params.engineType}');
    }
    if (params.transmissionType?.isNotEmpty == true) {
      keyParts.add('transmissionType_${params.transmissionType}');
    }
    if (params.seatType?.isNotEmpty == true) {
      keyParts.add('seatType_${params.seatType}');
    }

    // Always include page in cache key
    keyParts.add('page_${params.page ?? 1}');

    return keyParts.isEmpty ? 'default' : keyParts.join('_');
  }
}
