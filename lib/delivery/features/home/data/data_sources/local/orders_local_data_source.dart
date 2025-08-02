import 'package:x_go/delivery/features/home/data/model/order_status_hive_model.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';
import 'package:hive/hive.dart';

/// Abstract interface for local orders data operations
abstract class OrdersLocalDataSource {
  /// Cache orders to local storage with specified key
  Future<void> cacheOrders(List<OrderStatusEntity> orders, String key);

  /// Retrieve cached orders from local storage by key
  Future<List<OrderStatusEntity>> getCachedOrders(String key);
}

/// Local data source implementation using Hive for offline storage
/// Provides robust caching with error handling and data persistence
class OrdersLocalDataSourceImpl implements OrdersLocalDataSource {
  final Box _hiveBox;

  // Cache operation timeout to prevent hanging
  static const Duration _cacheTimeout = Duration(seconds: 10);

  OrdersLocalDataSourceImpl({required Box hiveBox}) : _hiveBox = hiveBox;

  @override
  Future<void> cacheOrders(List<OrderStatusEntity> orders, String key) async {
    try {
      // Convert entities to Hive models for storage
      final hiveModels = _convertToHiveModels(orders);

      // Perform cache operation with timeout protection
      await _performCacheOperation(() async {
        await _hiveBox.put(key, hiveModels);
        await _hiveBox.flush(); // Force immediate persistence to disk
      });
    } catch (e) {
      // Don't throw to maintain app stability
    }
  }

  @override
  Future<List<OrderStatusEntity>> getCachedOrders(String key) async {
    try {
      final cachedData = _hiveBox.get(key);
      // Handle null or empty cache
      if (_isCacheEmpty(cachedData)) {
        return <OrderStatusEntity>[];
      }
      // Safe conversion with error handling
      final entities = await _convertCacheToEntities(cachedData, key);
      return entities;
    } catch (e) {
      return <
        OrderStatusEntity
      >[]; // Always return list to maintain functionality
    }
  }

  /// Convert entities to Hive models for storage
  List<OrderStatusHiveModel> _convertToHiveModels(
    List<OrderStatusEntity> orders,
  ) {
    return orders.map(OrderStatusHiveModel.fromEntity).toList();
  }

  /// Perform cache operation with timeout protection
  Future<void> _performCacheOperation(Future<void> Function() operation) async {
    await operation().timeout(_cacheTimeout);
  }

  /// Check if cache data is null or empty
  bool _isCacheEmpty(dynamic cachedData) {
    return cachedData == null || (cachedData is List && cachedData.isEmpty);
  }

  /// Safely convert cached data to entities
  Future<List<OrderStatusEntity>> _convertCacheToEntities(
    dynamic cachedData,
    String key,
  ) async {
    try {
      // Safe type conversion
      final cachedList = List<OrderStatusHiveModel>.from(cachedData);
      // Convert to entities
      final entities = cachedList.map((model) => model.toEntity()).toList();
      return entities;
    } catch (e) {
      return <OrderStatusEntity>[];
    }
  }
}
