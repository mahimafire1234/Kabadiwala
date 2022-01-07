import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static SharedPreferences? _preferences;
  static String? _setUserType;
  static const String _userTokenKey = "user_token";
  static const String _adminTokenKey = "admin_token";
  static const String _id = "id";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setTokenWithType(String token, String userType) async {
    _setUserType = userType;
    if (_setUserType == "company") {
      await _preferences!.setString(_adminTokenKey, token);
    } else {
      await _preferences!.setString(_userTokenKey, token);
    }
  }

  static String? getToken() {
    if (_setUserType == "company") {
      return _preferences!.getString(_adminTokenKey);
    } else {
      return _preferences!.getString(_userTokenKey);
    }
  }

  static Future setId(String id) async =>
      await _preferences!.setString(_id, id);

  static String? get getId => _preferences!.getString(_id);

  static String? get getCurrentUserType =>
      _preferences!.getString(_setUserType!);
}
