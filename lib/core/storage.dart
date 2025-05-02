import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String _tokenKey = 'auth_token';
  static const String _citiesIdKey = 'cities_id';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> saveCitiesId(String citiesId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_citiesIdKey, citiesId);
  }

  static Future<String?> getCitiesId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_citiesIdKey);
  }

  static Future<void> clearCitiesId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_citiesIdKey);
  }
}
