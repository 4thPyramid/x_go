import 'package:x_go/core/constants/endpoints_strings.dart';
import 'package:x_go/core/data/api/api_consumer.dart';
import 'package:x_go/client/features/favorites/data/models/favorite_model.dart';

class FavoritesRepository {
  final ApiConsumer apiConsumer;

  FavoritesRepository({required this.apiConsumer});

  Future<List<FavoriteModel>> getFavorites() async {
    final response = await apiConsumer.get(EndpointsStrings.favorites);
    return (response as List)
        .map((favorite) => FavoriteModel.fromJson(favorite))
        .toList();
  }

  Future<String> toggleFavorite(String carId) async {
    final response = await apiConsumer.post(
      '${EndpointsStrings.favoritesToggle}/$carId',
    );
    return response['message'];
  }
}
