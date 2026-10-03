abstract class TableCarrier {
  static String tableName = 'carrier';
  static String id = 'id';

  static String createTable = '''
  CREATE TABLE $tableName(
    $id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
  )
  ''';
}