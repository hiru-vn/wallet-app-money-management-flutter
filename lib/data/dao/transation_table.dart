import 'package:sqflite/sqflite.dart';
import 'package:wallet_exe/data/model/Transaction.dart' as trans;

import '../database_helper.dart';

class TransactionTable {
  final tableName = 'transaction';
  final id = 'id';
  final date = 'date';
  final amount = 'amount';
  final description = 'description';
  final idCategory = 'id_category';
  final idAccount = 'id_account';
 
  void onCreate(Database db, int version) {
    db.execute('CREATE TABLE $tableName('
        '$id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$date TEXT,'
        '$amount INTEGER,'
        '$description TEXT,'
        '$idCategory INTEGER,'
        '$idAccount INTEGER,');
  }

  Future<int> insert(trans.Transaction transaction) async {
    // Checking backend validation
    transaction.checkValidationAndThrow();

    // Get a reference to the database.
    final Database db = await DatabaseHelper().db;

    // Insert the TransactionModel into the table. Also specify the 'conflictAlgorithm'.
    // In this case, if the same category is inserted multiple times, it replaces the previous data.
    return await db.insert(
      tableName,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> delete(int transactionId) async {
    // Get a reference to the database.
    final Database db = await DatabaseHelper().db;

    return db.delete(tableName, where: id + '=?', whereArgs: [transactionId]);
  }
}
