import '../model/UserAccount.dart';
import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';

class UserAccountTable {
  final tableName = 'user_account';
  final id = 'id';
  final name = 'name';
  final mail = 'mail';
  final password = 'password';
  final balance = 'balance';
  final themeColor = 'theme_color';

  void onCreate(Database db, int version) {
    db.execute('CREATE TABLE $tableName('
        '$id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$name TEXT NOT NULL,'
        '$mail TEXT NOT NULL,'
        '$password TEXT NOT NULL,'
        '$balance INTEGER NOT NULL,'
        '$themeColor INTEGER NOT NULL');
  }

  Future<int> insert(UserAccount userAccount) async {
    // Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

    // Insert the Category into the correct table.
    return db.insert(tableName, userAccount.toMap());
  }

  Future<int> update(UserAccount userAccount) async {
    // Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

    // Update the correct category.
    return db.update(
      tableName,
      userAccount.toMap(),
      // Ensure that the category has a matching id.
      where: "$id=?",
      // Pass the category's id as a whereArg to prevent SQL injection.
      whereArgs: [userAccount.id],
    );
  }
}
