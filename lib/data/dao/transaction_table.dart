import 'package:sqflite/sqflite.dart';
import 'package:wallet_exe/data/model/Transaction.dart' as trans;
import 'package:wallet_exe/enums/duration_filter.dart';
import 'package:wallet_exe/enums/transaction_type.dart';

import '../database_helper.dart';

class TransactionTable {
  final tableName = 'transaction_table';
  final id = 'id';
  final date = 'date';
  final amount = 'amount';
  final description = 'description';
  final idCategory = 'id_category';
  final idAccount = 'id_account';

  void onCreate(Database db, int version) {
    db.execute('CREATE TABLE $tableName('
        '$id INTEGER PRIMARY KEY,'
        '$date TEXT NOT NULL,'
        '$amount INTEGER NOT NULL,'
        '$description TEXT,'
        '$idCategory INTEGER NOT NULL,'
        '$idAccount INTEGER NOT NULL)');
  }

  Future<List<trans.Transaction>> getAll() async {
    final Database db = DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * from account, transaction_table , category where transaction_table.id_account = account.id and category.id = transaction_table.id_category');

    return List.generate(maps.length, (index) {
      return trans.Transaction.fromMap(maps[index]);
    });
  }

  //get income, outcome per duration
  List<int> getTotal(
    List<trans.Transaction> list, DurationFilter durationFilter) {
    List<int> result = List<int>();
    int income = 0;
    int outcome = 0;
    for (int i = 0; i < list.length; i++) {
      if (DurationFilter.checkValidInDurationFromNow(
          list[i].date, durationFilter)) {
        if (list[i].category.transactionType == TransactionType.INCOME)
          income += list[i].amount;
        if (list[i].category.transactionType == TransactionType.EXPENSE)
          outcome += list[i].amount;
      }
    }
    result.add(income);
    result.add(outcome);
    return result;
  }

  Future<int> insert(trans.Transaction transaction) async {
    // Checking backend validation
    transaction.checkValidationAndThrow();

    // Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

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
    final Database db = DatabaseHelper.instance.database;

    return db.delete(tableName, where: id + '=?', whereArgs: [transactionId]);
  }

  Future<void> update(trans.Transaction transaction) async {
    final Database db = DatabaseHelper.instance.database;
    //await db.update(tableName, where: 'id = ?', whereArgs: [transaction.id]);
  }
}
