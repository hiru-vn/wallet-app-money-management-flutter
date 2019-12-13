import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/data/dao/category_table.dart';
import 'package:wallet_exe/data/dao/spend_limit_table.dart';
import 'package:wallet_exe/data/dao/transation_table.dart';
import 'package:wallet_exe/data/dao/user_account_table.dart';

class DatabaseHelper {
  final String _databaseName = 'wallet_exe.db';
  final int _databaseVersion = 1;

  static Database _db;

  Future<Database> get db async {
    // Get a singleton database
    if (_db == null) {
      _db = await _initDb();
    }
    String databasesPath = await getDatabasesPath();
    print(databasesPath);
    return _db;
  }

  Future<Database> _initDb() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);

    // This will delete old/previous database when app is opened
    // Delete the database
    // await deleteDatabase(path);

    // Open the database
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    // Create other tables ...
    AccountTable().onCreate(db, version);
    CategoryTable().onCreate(db, version);
    SpendLimitTable().onCreate(db, version);
    //UserAccountTable().onCreate(db, version);
    TransactionTable().onCreate(db, version);
  }
}
