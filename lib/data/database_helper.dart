import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_exe/data/dao/account_table.dart';
import 'package:wallet_exe/data/dao/category_table.dart';
import 'package:wallet_exe/data/dao/spend_limit_table.dart';
import 'package:wallet_exe/data/dao/transaction_table.dart';

class DatabaseHelper {
  static const DB_NAME = 'wallet.db';
  static const DB_VERSION = 6;
  static Database _database;

  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  Database get database => _database;

  init() async{
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        AccountTable().onCreate(db, version);
        CategoryTable().onCreate(db, version);
        TransactionTable().onCreate(db, version);
        SpendLimitTable().onCreate(db, version);
      },
      onUpgrade: (db , oldVersion, newVersion) {
        AccountTable().onCreate(db, newVersion);
        CategoryTable().onCreate(db, newVersion);
        TransactionTable().onCreate(db, newVersion);
        SpendLimitTable().onCreate(db, newVersion);
      },
      version: DB_VERSION
    );
  }

  static const initScript2 = '''
CREATE TABLE transactionW (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"date"	TEXT NOT NULL,
	"amount"	INTEGER NOT NULL,
	"description"	TEXT,
	"idCategory"	INTEGER NOT NULL,
	"idAccount"	INTEGER NOT NULL
);
CREATE TABLE spend_limit (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"amount"	INTEGER NOT NULL,
	"type"	INTEGER NOT NULL
);
CREATE TABLE category (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"color"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL UNIQUE,
	"type"	INTEGER NOT NULL,
	"icon"	INTEGER NOT NULL
);
CREATE TABLE account (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"name"	TEXT NOT NULL UNIQUE,
	"balance"	INTEGER NOT NULL,
	"type"	INTEGER NOT NULL,
	"icon"	INTEGER NOT NULL
);
INSERT INTO spend_limit VALUES (1,3000000,1);
INSERT INTO spend_limit VALUES (2,1000000,0);
INSERT INTO category VALUES (1,0,'Con cái',0,0);
INSERT INTO category VALUES (2,0,'Nhà cửa',0,0);
INSERT INTO category VALUES (3,0,'Đi lại',0,0);
INSERT INTO category VALUES (4,0,'Học tập',0,0);
INSERT INTO category VALUES (5,0,'Mua sắm',0,0);
INSERT INTO category VALUES (6,0,'Ăn uống',0,0);
INSERT INTO category VALUES (7,0,'Giải trí',0,0);
INSERT INTO category VALUES (8,0,'Quần áo',0,0);
INSERT INTO account VALUES (0,'Ví',0,0,0);
INSERT INTO account VALUES (1,'ATM',0,0,0);
INSERT INTO account VALUES (2,'MOMO',0,0,0);
  ''';
}