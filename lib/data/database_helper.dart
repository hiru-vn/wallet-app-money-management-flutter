import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:sqlite/db/todo_table.dart';

class DatabaseHelper {
  static const DB_NAME = 'wallet_exe.db';
  static const DB_VERSION = 1;
  static Database _database;

  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  Database get database => _database;

  //static const initScript = [TodoTable.CREATE_TABLE_QUERY];
  //static const migrationScript = [TodoTable.CREATE_TABLE_QUERY];

  init() async{
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        //initScript.forEach((script) async => await db.execute(script));
        db.execute(initScript);
      },
      onUpgrade: (db , oldVersion, newVersion) {
        //migrationScript.forEach((script) async => await db.execute(script));
        db.execute(initScript);
      },
      version: DB_VERSION
    );
  }

  static const initScript = '''
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "transaction" (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"date"	TEXT NOT NULL,
	"amount"	INTEGER NOT NULL,
	"description"	TEXT,
	"idCategory"	INTEGER NOT NULL,
	"idAccount"	INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "spend_limit" (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"amount"	INTEGER NOT NULL,
	"type"	INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "category" (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"color"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL UNIQUE,
	"type"	INTEGER NOT NULL,
	"icon"	INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS "account" (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"name"	TEXT NOT NULL UNIQUE,
	"balance"	INTEGER NOT NULL,
	"type"	INTEGER NOT NULL,
	"icon"	INTEGER NOT NULL
);
INSERT INTO "spend_limit" VALUES (1,3000000,1);
INSERT INTO "spend_limit" VALUES (2,1000000,0);
INSERT INTO "category" VALUES (1,0,'Con cái',0,0);
INSERT INTO "category" VALUES (2,0,'Nhà cửa',0,0);
INSERT INTO "category" VALUES (3,0,'Đi lại',0,0);
INSERT INTO "category" VALUES (4,0,'Học tập',0,0);
INSERT INTO "category" VALUES (5,0,'Mua sắm',0,0);
INSERT INTO "category" VALUES (6,0,'Ăn uống',0,0);
INSERT INTO "category" VALUES (7,0,'Giải trí',0,0);
INSERT INTO "category" VALUES (8,0,'Quần áo',0,0);
INSERT INTO "account" VALUES (0,'Ví',0,0,0);
INSERT INTO "account" VALUES (1,'ATM',0,0,0);
INSERT INTO "account" VALUES (2,'MOMO',0,0,0);
COMMIT;
  ''';
}