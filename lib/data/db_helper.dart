import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/models/todo_item.dart';

class DatabaseHelper {
  static const _databaseName = "todo_database.db";
  static const _databaseVersion = 1;

  static const table = "todos";

  static const columnId = "id";
  static const columnTitle = "title";
  static const columnDescription = "description";
  static const columnDate = "deadline";
  static const columnDone = "done";

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

//***********tällä voi tuhota tietokannan, kun siinä menee joku pieleen********' */
    // deleteDatabase(path);

    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT,
            $columnDate INTEGER NOT NULL,
            $columnDone INTEGER NOT NULL
            )''');
  }

  Future<int> insert(TodoItem item) async {
    return await _db.insert(table, item.toMap());
  }

  Future<List<TodoItem>> queryAllRows() async {
    final List<Map<String, dynamic>> maps = await _db.query(table);

    return List.generate(maps.length, (i) {
      return TodoItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        deadline: DateTime.fromMillisecondsSinceEpoch(maps[i]['deadline']),
        done: maps[i]['done'] == 1,
      );
    });
  }

  Future<int> update(TodoItem item) async {
    log("message TESTI TESTI TESTI");
    return await _db.update(
      table,
      item.toMap(),
      where: '$columnId = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    return await _db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
