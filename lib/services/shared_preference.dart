import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static SharedPreferences? _preferences;
  static String? _setUserType;
  static const String _userTokenKey = "user_token";
  static const String _adminTokenKey = "admin_token";
  static const String _id = "id";
  static const String _LoginId = "LoginId";
  static const String _usertype = "usertype";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setTokenWithType(String token, String userType) async {
    await _preferences!.setString(_usertype, userType);
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

  static Future setUsertype(String usertype) async =>
      await _preferences!.setString(_usertype, usertype);

  static String? get getUsertype => _preferences!.getString(_usertype);

  static String? get getCurrentUserType =>
      _preferences!.getString(_setUserType!);

  static Future setLoginId(String LoginId) async =>
      await _preferences!.setString(_LoginId, LoginId);

  static String? get getLoginId => _preferences!.getString(_LoginId);

  static void removeAll() => _preferences!.clear();
}
