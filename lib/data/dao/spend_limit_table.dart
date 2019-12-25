import '../model/SpendLimit.dart';
import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';

class SpendLimitTable {
  final tableName = 'spend_limit';
  final id = 'id';
  final amount = 'amount';
  final type = 'type';

  void onCreate(Database db, int version) {
    db.execute('CREATE TABLE $tableName('
        '$id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$amount INTEGER NOT NULL,'
        '$type INTEGER NOT NULL)');

    db.execute('INSERT INTO spend_limit(amount, type) VALUES(1000000,0)');
    db.execute('INSERT INTO spend_limit(amount, type) VALUES(4000000,1)');
    db.execute('INSERT INTO spend_limit(amount, type) VALUES(12000000,2)');
    db.execute('INSERT INTO spend_limit(amount, type) VALUES(48000000,3)');
  }

  Future<int> insert(SpendLimit spendLimit) async {
    // Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

    // Insert the SpendLimit into the correct table.
    return db.insert(tableName, spendLimit.toMap());
  }

  Future<List<SpendLimit>> getAll() async {
    // Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

    // Query the table for all The Categories.
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    // Convert the List<Map<String, dynamic> into a List<SpendLimit>.
    return List.generate(maps.length, (i) {
      return SpendLimit.fromMap(maps[i]);
    });
  }

  Future<int> delete(int spendLimitId) async {
    // Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

    return db.delete(tableName, where: id + '=?', whereArgs: [spendLimitId]);
  }

  Future<int> update(SpendLimit spendLimit) async {
    // Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

    // Update the correct SpendLimit.
    return db.update(
      tableName,
      spendLimit.toMap(),
      // Ensure that the SpendLimit has a matching id.
      where: "$id=?",
      // Pass the SpendLimit's id as a whereArg to prevent SQL injection.
      whereArgs: [spendLimit.id],
    );
  }
}
