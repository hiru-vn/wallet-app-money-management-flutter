
import '../model/Category.dart';
import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';


class CategoryTable {
  final tableName = 'category';
  final id = 'id';
  final color = 'color';
  final name = 'name';
  final type = 'type';
  final icon = 'icon';
  final description = 'description';

  void onCreate(Database db, int version) {
    db.execute('CREATE TABLE $tableName('
        '$id INTEGER PRIMARY KEY,'
        '$color INTEGER NOT NULL,'
        '$name TEXT NOT NULL UNIQUE,'
        '$type INTEGER NOT NULL,'
        '$description STRING,'
        '$icon INT NOT NULL)');

    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "nhà cửa", 1, 59530)');
    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "con cái", 1, 60225)');
    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "quần áo", 1, 58164)');
    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "giải trí", 1, 58162)');
    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "du lịch", 1, 57749)');
    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "di chuyển", 1, 58673)');
    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "điện nước", 1, 58940)');
    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "làm đẹp", 1, 59516)');
    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "ăn uống", 1, 58746)');
    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "lãnh lương", 0, 57895)');
    db.execute(
        'INSERT INTO category(color, name, type, icon) VALUES (1, "được cho/tặng", 0, 59638)');
  }

  Future<int> insert(Category category) async {
// Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

// Insert the Category into the correct table.
    return db.insert(tableName, category.toMap());
  }

  Future<List<Category>> getAll() async {
// Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

// Query the table for all The Categories.
    final List<Map<String, dynamic>> maps = await db.query(tableName);

// Convert the List<Map<String, dynamic> into a List<Category>.
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  Future<int> delete(int categoryId) async {
// Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

    return db.delete(tableName, where: id + '=?', whereArgs: [categoryId]);
  }

  Future<int> update(Category category) async {
// Get a reference to the database.
    final Database db = DatabaseHelper.instance.database;

// Update the correct category.
    return db.update(
      tableName,
      category.toMap(),
// Ensure that the category has a matching id.
      where: "$id=?",
// Pass the category's id as a whereArg to prevent SQL injection.
      whereArgs: [category.id],
    );
  }
}
