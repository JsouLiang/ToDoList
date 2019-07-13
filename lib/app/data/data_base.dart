import 'dart:io';

import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/app/data/todo_task.dart';
import 'package:todo_list/app/utils/date_time.dart';

class DataBase {
  final String userName;
  DataBase({this.userName});

  Future<String> get _dbPath async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = Path.join(documentsDirectory.path, "$userName.db");
    return path;
  }

  Future<Database> get _localFile async {
    final path = await _dbPath;

    Database database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE tasks (id TEXT PRIMARY KEY, title TEXT, description TEXT, fromTime TEXT, toTime TEXT,finished INTEGER,import INTEGER, location TEXT, priority INTEGER)");
    });
    return database;
  }

  Future<void> insert(TodoTask obj) async {
    final Database dataBase = await _localFile;
    Map value = obj.toJson();
    dataBase.insert("tasks", value, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TodoTask>> data() async {
    final Database database = await _localFile;
    final List<Map<String, dynamic>> maps = await database.query("tasks");
    return List.generate(maps.length, (i) {
      bool finished = maps[i]["finished"] == 1;
      bool import = maps[i]["import"] == 1;
      return TodoTask(
          id: maps[i]["id"],
          title: maps[i]["title"],
          description: maps[i]["description"],
          fromTime: DateTimeFormatter.dateFromTimeString(maps[i]["fromTime"]),
          toTime: DateTimeFormatter.dateFromTimeString(maps[i]["toTime"]),
          finished: finished,
          import: import);
    });
  }

  Future<void> updateTask(TodoTask task) async {
    final Database database = await _localFile;
    int res = await database.update("tasks", task.toJson(), where: "id = ?", whereArgs: [task.id]);
    print(res);
  }

  Future<void> delete(String id) async {
    final database = await _localFile;
    await database.delete("tasks", where: "id = ?", whereArgs: [id]);
  }
}
