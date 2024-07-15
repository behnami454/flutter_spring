import 'package:shared_preferences/shared_preferences.dart';
import 'package:qrmenu/models/user_model/user_model.dart';

class SharedPreferencesService {
  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';

  static Future<void> saveUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyPassword, password);
  }

  static Future<AppUser?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_keyUsername);
    final password = prefs.getString(_keyPassword);

    if (username != null && password != null) {
      return AppUser(username: username, password: password);
    } else {
      return null;
    }
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyPassword);
  }
}
