import 'package:sqflite/sqflite.dart';
import 'package:wallet_exe/data/model/Transaction.dart' as trans;
import 'package:wallet_exe/enums/duration_filter.dart';
import 'package:wallet_exe/enums/spend_limit_type.dart';
import 'package:wallet_exe/enums/transaction_type.dart';
import 'package:wallet_exe/widgets/item_spend_chart_circle.dart';

import '../database_helper.dart';

class TransactionTable {
  final tableName = 'transaction_table';
  final id = 'id_transaction';
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
    
    db.execute('INSERT INTO $tableName VALUES(null,"2007-01-01 10:00:00",0,"",1,1)');
  }

  Future<List<trans.Transaction>> getAll() async {
    final Database db = DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery( // watch out!! this could be buggy, more than one column name id
        'SELECT * from transaction_table, account , category where transaction_table.id_account = account.id_account and category.id = transaction_table.id_category');

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
    await db.update(tableName, transaction.toMap() , where: '$id = ?', whereArgs: [transaction.id]);
  }

  Future<List<CategorySpend>> getAmountSpendPerCategory(TransactionType type) async {
    final Database db = DatabaseHelper.instance.database;
    int typeid = type.value;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'select category.name as name, sum(amount) as sum from category, transaction_table where category.id = transaction_table.id_category and category.type = $typeid GROUP by category.id ORDER by sum DESC');
    return List.generate(maps.length, (index) {
      return CategorySpend(maps[index]['name'], maps[index]['sum']);
    });
  }

  // return the amount that would reach to spend limit
  Future<int> getMoneySpendByDuration(SpendLimitType type) async {
    int result=0;
    final Database db = DatabaseHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * from account, transaction_table , category where transaction_table.id_account = account.id_account and category.id = transaction_table.id_category');
    List<trans.Transaction> list = List.generate(maps.length, (index) {
      return trans.Transaction.fromMap(maps[index]);
    });
    list=list.where((item) => item.category.transactionType == TransactionType.EXPENSE).toList();

    if (type == SpendLimitType.MONTHLY) {
      for (int i =0; i< list.length; i++) {
        if (list[i].date.month == DateTime.now().month){
          result+=list[i].amount;
        }
      }
    }
    return result;
  }
}
