import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static SharedPreferences? _preferences;
  static String? _setUserType;
  static const String _userTokenKey = "user_token";
  static const String _adminTokenKey = "admin_token";
  static const String _id = "id";
  static const String _LoginId = "LoginId";
  static const String _email = "email";
  static const String _password = "password";
  static const String _usertype = "usertype";
  static const String _checkvalue = "checkValue";
  static const String _token = "token";

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

  static Future setToken(String token) async =>
      await _preferences!.setString(_token, token);
  static String? get getTokenOnly => _preferences!.getString(_token);

  static Future setUsertype(String usertype) async =>
      await _preferences!.setString(_usertype, usertype);

  static String? get getUsertype => _preferences!.getString(_usertype);

  static Future setPassword(String password) async =>
      await _preferences!.setString(_password, password);

  static String? get getPassword => _preferences!.getString(_password);

  static Future setEmail(String email) async =>
      await _preferences!.setString(_email, email);

  static String? get getEmail => _preferences!.getString(_email);

  static String? get getCurrentUserType =>
      _preferences!.getString(_setUserType!);

  static Future setLoginId(String loginId) async =>
      await _preferences!.setString(_LoginId, loginId);

  static String? get getLoginId => _preferences!.getString(_LoginId);

  static Future setCheckValue(bool checkValue) async =>
      await _preferences!.setBool(_checkvalue, checkValue);

  static String? get getCheckValue => _preferences!.getString(_checkvalue);

  static Future removeSavedDetails() async => await _preferences!.clear();
}
