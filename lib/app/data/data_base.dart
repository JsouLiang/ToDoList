import 'dart:io';

import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class Mapable {
  Mapable.from(Map<String, dynamic> info);
  Map<String, dynamic> toMap();
}

class DataBase<T extends Mapable> {
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
          "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, description TEXT, fromTime TEXT, toTime TEXT,finished INTEGER,import INTEGER)");
    });
    return database;
  }

  Future<void> insert(T obj) async {
    final Database dataBase = await _localFile;
    dataBase.insert("tasks", obj.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<T>> data() async {
    final Database database = await _localFile;
    final List<Map<String, dynamic>> maps = await database.query("tasks");
    return List.generate(maps.length, (info) {});
  }
}
