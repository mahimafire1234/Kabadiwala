import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static SharedPreferences? _preferences;
  static const String _tokenKey = "token";
  static const String _userKey = "Username";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setToken(String token) async =>
      await _preferences!.setString(_tokenKey, token);
  static String? getToken() => _preferences!.getString(_tokenKey);
}
