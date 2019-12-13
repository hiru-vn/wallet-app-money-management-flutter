import '../model/Account.dart';
import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';

class AccountTable {
  final tableName = 'account';
  final id = 'id';
  final name = 'name';
  //final int idAppAccount; //TO DO
  final balance = 'balance';
  final type = 'type';
  final icon = 'icon';

  void onCreate(Database db, int version) {
    db.execute('CREATE TABLE $tableName('
        '$id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$name TEXT NOT NULL UNIQUE,'
        '$balance INTEGER NOT NULL,'
        '$type INTEGER NOT NULL)'
        '$icon INTEGER NOT NULL)');
  }

  Future<int> insert(Account account) async {
    // Get a reference to the database.
    final Database db = await DatabaseHelper().db;

    // Insert the Account into the correct table.
    return db.insert(tableName, account.toMap());
  }
}