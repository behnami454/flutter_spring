import 'package:qrmenu/models/user_model/user_model.dart';
import 'package:qrmenu/services/api_service.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<String> registerUser(AppUser user) async {
    return await apiService.registerUser(user);
  }

  Future<String> loginUser(AppUser user) async {
    return await apiService.loginUser(user);
  }
}
