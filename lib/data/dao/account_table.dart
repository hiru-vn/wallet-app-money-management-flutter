import 'package:flutter/material.dart';

import '../model/Account.dart';
import 'package:sqflite/sqflite.dart';
import '../../enums/account_type.dart';

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
        '$type INTEGER NOT NULL,'
        '$icon INTEGER NOT NULL)');

    insert(Account(0,'Ví',0, AccountType.SPENDING, Icons.account_balance_wallet));
    insert(Account(1,'ATM',0, AccountType.SPENDING, Icons.atm));
  }

  Future<int> insert(Account account) async {
    // Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

    // Insert the Account into the correct table.
    return db.insert(tableName, account.toMap());
  }

  Future<String> getTotalBalance() async {
    final Database db = DatabaseHelper.instance.database;
    String rawQuery = 'SELECT SUM(balance) FROM $tableName';

    final List<Map<String, dynamic>> map = await db.rawQuery(rawQuery);
    return map[0].values.toString();
  }

}