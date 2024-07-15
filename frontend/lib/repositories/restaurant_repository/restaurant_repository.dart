import 'package:qrmenu/models/restaurant_model/restaurant_model.dart';
import 'package:qrmenu/services/api_service.dart';

class RestaurantRepository {
  final ApiService apiService;

  RestaurantRepository({required this.apiService});

  Future<List<Restaurant>> fetchRestaurants() {
    return apiService.getRestaurants();
  }

  Future<Restaurant> createRestaurant(Restaurant restaurant) {
    return apiService.createRestaurant(restaurant);
  }

  Future<void> updateRestaurant(Restaurant restaurant) {
    return apiService.updateRestaurant(restaurant);
  }

  Future<void> deleteRestaurant(int id) {
    return apiService.deleteRestaurant(id);
  }
}
