
class TodoTable {
  static const TABLE_NAME = 'todo';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME (
      id INTEGER PRIMARY KEY,
      content TEXT)
  ''';
  static const DROP_QUERRY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';

}