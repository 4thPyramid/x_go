import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/client/features/home/data/datasources/car_remote_datasource_impl.dart';
import 'package:x_go/client/features/home/data/datasources/car_local_datasource_impl.dart';
import 'package:x_go/client/features/home/data/models/filter_info_model.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';
import 'package:x_go/client/features/home/domain/repo/car_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  // Cache configuration
  static const Duration _cacheMaxAge = Duration(minutes: 15);
  static const Duration _filterInfoCacheMaxAge = Duration(hours: 24);

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<ErrorModel, List<CarEntity>>> getCars(
    HomeRequestParams params,
  ) async {
    final cacheKey = HomeLocalDataSourceImpl.generateCacheKey(params);

    try {
      // 1. Try to load from cache first
      final cachedResponse = await localDataSource.getCachedCars(cacheKey);
      List<CarEntity>? cachedCars;

      if (cachedResponse != null &&
          localDataSource.isCacheValid(cacheKey, _cacheMaxAge)) {
        // Convert cached data to entities
        cachedCars = cachedResponse.data
            .map((carModel) => carModel.toEntity())
            .toList();

        // Remove duplicates based on car id
        final uniqueCachedCars = <String, CarEntity>{};
        for (var car in cachedCars) {
          uniqueCachedCars[car.id] = car;
        }
        cachedCars = uniqueCachedCars.values.toList();
      }

      // 2. If we have valid cached data, return it immediately
      if (cachedCars != null) {
        // Silently update cache in background (don't await)
        _updateCacheInBackground(params, cacheKey);
        return Right(cachedCars);
      }

      // 3. If no cached data or cache is invalid, fetch from remote
      return await _fetchFromRemoteAndCache(params, cacheKey);
    } catch (e) {
      // If anything goes wrong, try to fetch from remote
      return await _fetchFromRemoteAndCache(params, cacheKey);
    }
  }

  @override
  Future<Either<ErrorModel, FilterInfo>> getFilterInfo() async {
    try {
      // 1. Try to load from cache first
      final cachedResponse = await localDataSource.getCachedFilterInfo();

      if (cachedResponse != null &&
          localDataSource.isCacheValid('filter_info', _filterInfoCacheMaxAge)) {
        // Convert cached data to entity
        final filterInfo = FilterInfo(
          brands: cachedResponse.brands
              .map(
                (brand) => Brand(
                  id: brand.id,
                  name: brand.attributes.name,
                  logo: brand.attributes.logo,
                ),
              )
              .toList(),
          types: cachedResponse.types
              .map((type) => CarType(name: type.name))
              .toList(),
          years: cachedResponse.years,
          maxPrice: cachedResponse.maxPrice,
          minPrice: cachedResponse.minPrice,
        );

        // Silently update cache in background
        _updateFilterInfoCacheInBackground();
        return Right(filterInfo);
      }

      // 2. If no cached data or cache is invalid, fetch from remote
      return await _fetchFilterInfoFromRemoteAndCache();
    } catch (e) {
      return await _fetchFilterInfoFromRemoteAndCache();
    }
  }

  /// Fetch cars from remote and cache the result
  Future<Either<ErrorModel, List<CarEntity>>> _fetchFromRemoteAndCache(
    HomeRequestParams params,
    String cacheKey,
  ) async {
    try {
      final response = await remoteDataSource.getCars(params);

      // Cache the response
      await localDataSource.cacheCars(cacheKey, response);

      // Convert to entities
      final cars = response.data
          .map((carModel) => carModel.toEntity())
          .toList();

      // Remove duplicates based on car id
      final uniqueCars = <String, CarEntity>{};
      for (var car in cars) {
        uniqueCars[car.id] = car;
      }

      return Right(uniqueCars.values.toList());
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  /// Fetch filter info from remote and cache the result
  Future<Either<ErrorModel, FilterInfo>>
  _fetchFilterInfoFromRemoteAndCache() async {
    try {
      final response = await remoteDataSource.getFilterInfo();

      // Cache the response
      await localDataSource.cacheFilterInfo(response);

      final filterInfo = FilterInfo(
        brands: response.brands
            .map(
              (brand) => Brand(
                id: brand.id,
                name: brand.attributes.name,
                logo: brand.attributes.logo,
              ),
            )
            .toList(),
        types: response.types.map((type) => CarType(name: type.name)).toList(),
        years: response.years,
        maxPrice: response.maxPrice,
        minPrice: response.minPrice,
      );

      return Right(filterInfo);
    } on DioException catch (e) {
      return Left(ErrorModel(message: e.message.toString()));
    } on ServerException catch (e) {
      return Left(e.errorModel);
    }
  }

  /// Update cache in background without blocking the UI
  void _updateCacheInBackground(HomeRequestParams params, String cacheKey) {
    // Run in background without awaiting
    Future.microtask(() async {
      try {
        final response = await remoteDataSource.getCars(params);
        await localDataSource.cacheCars(cacheKey, response);
      } catch (e) {
        // Fail silently in background update
      }
    });
  }

  /// Update filter info cache in background
  void _updateFilterInfoCacheInBackground() {
    Future.microtask(() async {
      try {
        final response = await remoteDataSource.getFilterInfo();
        await localDataSource.cacheFilterInfo(response);
      } catch (e) {
        // Fail silently in background update
      }
    });
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    await localDataSource.clearAllCache();
  }

  /// Clear only cars cache
  Future<void> clearCarsCache() async {
    await localDataSource.clearCarsCache();
  }
}
