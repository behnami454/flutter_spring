import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qrmenu/models/restaurant_model/restaurant_model.dart';
import 'package:qrmenu/models/user_model/user_model.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.103:8080';

  Future<String> registerUser(AppUser user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return "User registered successfully";
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<String> loginUser(AppUser user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['token'];
    } else {
      throw Exception('Failed to login user');
    }
  }

  Future<Restaurant> createRestaurant(Restaurant restaurant) async {
    final response = await http.post(
      Uri.parse('$baseUrl/places'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(restaurant.toJson()),
    );
    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create restaurant');
    }
  }

  Future<List<Restaurant>> getRestaurants() async {
    final response = await http.get(Uri.parse('$baseUrl/places'));
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Restaurant>.from(l.map((model) => Restaurant.fromJson(model)));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<void> updateRestaurant(Restaurant restaurant) async {
    final response = await http.put(
      Uri.parse('$baseUrl/places/${restaurant.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(restaurant.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update restaurant');
    }
  }

  Future<void> deleteRestaurant(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/places/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete restaurant');
    }
  }
}
