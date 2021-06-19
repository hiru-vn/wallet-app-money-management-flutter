
import '../model/UserAccount.dart';
import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';

class UserAccountTable {
  final tableName = 'user_account';
  final id = 'id';
  final name = 'name';
  final email = 'email';
  final password = 'password';

  void onCreate(Database db, int version) {
    db.execute('''
    CREATE TABLE $tableName(
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $name TEXT NOT NULL,
        $email TEXT NOT NULL,
        $password TEXT NOT NULL)
      ''');
  }

  Future<UserAccount> getUser(String email, String password) async {
    final Database db = DatabaseHelper.instance.database;
    String rawQuery =
        'SELECT * from user_account where user_account.email = ? and user_account.password = ?';
    final List<Map<String, dynamic>> map =
        await db.rawQuery(rawQuery, [email, password]);
    if (map.isNotEmpty)
      return UserAccount.fromMap(map[0]);
    else
      return null;
  }

  Future<int> insert(UserAccount userAccount) async {
    // Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

    // Insert the Category into the correct table.
    final id = await db.insert(tableName, userAccount.toMap());

    return  id;
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
