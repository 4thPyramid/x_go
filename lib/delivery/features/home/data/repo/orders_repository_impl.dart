import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:x_go/core/errors/error_model.dart';
import 'package:x_go/core/errors/exceptions.dart';
import 'package:x_go/delivery/features/home/data/data_sources/local/orders_local_data_source.dart';
import 'package:x_go/delivery/features/home/data/data_sources/remote/oreders_status_ds.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';
import 'package:x_go/delivery/features/home/domain/repos/orders_repository.dart';

/// Repository implementation for managing orders data
/// Handles both remote API calls and local caching for offline support
class OrdersStatusRepositoryImpl implements OrdersStatusRepository {
  final OrdersStatusDataSource _remoteDataSource;
  final OrdersLocalDataSource _localDataSource;

  // Constants for cache keys
  static const String _acceptedOrdersKey = 'accepted_orders';
  static const String _newOrdersKey = 'new_orders';
  static const String _completedOrdersKey = 'completed_orders';

  OrdersStatusRepositoryImpl({
    required OrdersLocalDataSource localDataSource,
    required OrdersStatusDataSource dataSource,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = dataSource;

  @override
  Future<Either<ErrorModel, List<OrderStatusEntity>>>
  getAcceptedOrders() async {
    return _getOrdersWithCache(
      cacheKey: _acceptedOrdersKey,
      remoteCall: () => _remoteDataSource.getAcceptedOrders(),
      orderType: 'Accepted Orders',
    );
  }

  @override
  Future<Either<ErrorModel, List<OrderStatusEntity>>> getNewOrders() async {
    return _getOrdersWithCache(
      cacheKey: _newOrdersKey,
      remoteCall: () => _remoteDataSource.getNewOrders(),
      orderType: 'New Orders',
    );
  }

  @override
  Future<Either<ErrorModel, List<OrderStatusEntity>>>
  getCompletedOrders() async {
    return _getOrdersWithCache(
      cacheKey: _completedOrdersKey,
      remoteCall: () => _remoteDataSource.getCompletedOrders(),
      orderType: 'Completed Orders',
    );
  }

  ///  method to handle orders fetching with caching strategy
  /// 1. Try to fetch from remote API
  /// 2. If successful, cache and return data
  /// 3. If failed, try to return cached data
  /// 4. Handle specific error cases (no bookings, network errors)
  Future<Either<ErrorModel, List<OrderStatusEntity>>> _getOrdersWithCache({
    required String cacheKey,
    required Future<dynamic> Function() remoteCall,
    required String orderType,
  }) async {
    try {
      // Step 1: Try to fetch from remote API
      final response = await remoteCall();

      if (response.data != null && response.data!.isNotEmpty) {
        // Step 2: Convert and cache successful response
        final orders = _convertToEntities(response.data!);
        await _cacheOrdersSafely(orders, cacheKey);
        return Right(orders);
      } else {
        // Step 3: No data from API, try cache
        return _getCachedOrders(cacheKey);
      }
    } catch (e) {
      // Step 4: Handle different error types
      return _handleError(e, cacheKey, orderType);
    }
  }

  /// Convert list of models to entities
  List<OrderStatusEntity> _convertToEntities(List<dynamic> data) {
    return data
        .map((item) => (item as dynamic).toEntity() as OrderStatusEntity)
        .toList();
  }

  /// Safely cache orders with error handling
  Future<void> _cacheOrdersSafely(
    List<OrderStatusEntity> orders,
    String cacheKey,
  ) async {
    try {
      await _localDataSource.cacheOrders(orders, cacheKey);
    } catch (e) {
      print('Error caching orders: $e');
    }
  }

  /// Handle different types of errors with appropriate fallback strategies
  Future<Either<ErrorModel, List<OrderStatusEntity>>> _handleError(
    dynamic error,
    String cacheKey,
    String orderType,
  ) async {
    if (error is ServerException) {
      return _handleServerException(error, cacheKey);
    } else if (error is DioException) {
      return _handleNetworkException(error, cacheKey);
    } else {
      return _handleGenericException(error, cacheKey);
    }
  }

  /// Handle server exceptions (404, 500, etc.)
  Future<Either<ErrorModel, List<OrderStatusEntity>>> _handleServerException(
    ServerException error,
    String cacheKey,
  ) async {
    // Check if it's a "no bookings" case - this is normal
    if (error.errorModel.message.toLowerCase().contains('no bookings')) {
      await _cacheOrdersSafely([], cacheKey);
      return Right([]);
    }

    // For other server errors, try cache
    final cachedResult = await _getCachedOrders(cacheKey);
    return cachedResult.fold(
      (cacheError) => Left(error.errorModel),
      (orders) => Right(orders),
    );
  }

  /// Handle network exceptions (no internet, timeout, etc.)
  Future<Either<ErrorModel, List<OrderStatusEntity>>> _handleNetworkException(
    DioException error,
    String cacheKey,
  ) async {
    final cachedResult = await _getCachedOrders(cacheKey);
    return cachedResult.fold(
      (cacheError) =>
          Left(ErrorModel(message: 'Network error: ${error.message}')),
      (orders) => Right(orders),
    );
  }

  /// Handle generic exceptions
  Future<Either<ErrorModel, List<OrderStatusEntity>>> _handleGenericException(
    dynamic error,
    String cacheKey,
  ) async {
    final cachedResult = await _getCachedOrders(cacheKey);
    return cachedResult.fold(
      (cacheError) =>
          Left(ErrorModel(message: 'Unexpected error: ${error.toString()}')),
      (orders) => Right(orders),
    );
  }

  /// Get cached orders with proper error handling
  /// Always returns success (even with empty list) to maintain app functionality
  Future<Either<ErrorModel, List<OrderStatusEntity>>> _getCachedOrders(
    String cacheKey,
  ) async {
    try {
      final cached = await _localDataSource.getCachedOrders(cacheKey);
      return Right(cached);
    } catch (e) {
      return Left(
        ErrorModel(message: 'Error accessing cached orders: ${e.toString()}'),
      );
    }
  }
}
