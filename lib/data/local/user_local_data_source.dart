import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_exe/data/local/key_shared_preferences.dart';
import 'package:wallet_exe/data/model/User.dart';

class UserLocalDataSource {
  static final UserLocalDataSource _instance = UserLocalDataSource._internal();

  static SharedPreferences _preferences;

  factory UserLocalDataSource() {
    return _instance;
  }

  UserLocalDataSource._internal();

  static Future<void> initData() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveUserCurrent(UserModel user) async {
    return await _preferences.setString(
        KEY_SP_CURRENT_USER, user != null ? jsonEncode(user.toMap()) : null);
  }

  UserModel getUserCurrent() {
    String userString = _preferences.getString(KEY_SP_CURRENT_USER);
    return userString != null
        ? UserModel.fromMap(jsonDecode(userString))
        : null;
  }
}
