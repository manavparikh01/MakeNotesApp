import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class SqlStore {
  static Future<sql.Database> database() async {
    final sqlPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(sqlPath, 'notes.db'),
        onCreate: (db, verion) {
      return db.execute(
          'CREATE TABLE user_notes(id TEXT PRIMARY KEY, title TEXT, text TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await SqlStore.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await SqlStore.database();
    return db.query(table);
  }
}
