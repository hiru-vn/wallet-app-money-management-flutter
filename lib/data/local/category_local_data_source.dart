import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_exe/data/local/key_shared_preferences.dart';
import 'package:wallet_exe/data/model/Category.dart';

class CategoryLocalDataSource {
  static final CategoryLocalDataSource _instance =
      CategoryLocalDataSource._internal();

  static SharedPreferences _preferences;

  factory CategoryLocalDataSource() {
    return _instance;
  }

  CategoryLocalDataSource._internal();

  Future<bool> saveCategories(List<Category> categories) async {
    return await _preferences.setString(
        KEY_CATEGORIES,
        categories != null
            ? jsonEncode(categories.map((e) => e.toMap()).toList())
            : null);
  }
}
