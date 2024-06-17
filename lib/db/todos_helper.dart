
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todos_app/controller/todos_controller.dart';
import 'package:todos_app/models/task_model.dart';

class TodosHelper {

  static const String _databaseName = "todos.db";
  static const int _databaseVersion = 1;

  static const String table = "_todos";
  static const String columnTaskId = "_id";
  static const String columnAlarmID = "_alarmID";
  static const String columnTaskTitle =  "_title";
  static const String columnTaskDate = "_date";
  static const String columnTaskTime = "_time";
  static const String columnColor = "_color";
  static const String columnTimeStamp = "_timeStamp";
  static const String columnCategory =  "_category";
  static const String columnColorIndex =  "_colorIndex";
  static const String columnCategoryIndex =  "_categoryIndex";

  // make this a singleton class
  TodosHelper._privateConstructor();
  static final TodosHelper instance = TodosHelper._privateConstructor();

  static Database? _database;
  Future<Database?> createDB() async {
    if(_database != null) return _database;
    _database = await _init();
    return _database;
  }
  Future _init() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName); // Corrected the join function call
    return await openDatabase(path, version: _databaseVersion, onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $table (
        $columnTaskId INTEGER PRIMARY KEY,
        $columnAlarmID INTEGER NOT NULL,
        $columnTaskTitle TEXT NOT NULL,
        $columnTaskDate TEXT NOT NULL,
        $columnTaskTime TEXT NOT NULL,
        $columnColor TEXT NOT NULL,
        $columnTimeStamp INTEGER NOT NULL,
        $columnCategory TEXT NOT NULL,
        $columnColorIndex INTEGER NOT NULL,
        $columnCategoryIndex INTEGER NOT NULL
      )
      ''');
    });
  }
  Future<int?> insertTodo(TaskModel taskModel) async {
     var db = await createDB();
     return await db?.insert(table, taskModel.toJson());
  }
  Future<List<TaskModel>?>getTodos() async {
    var db = await createDB();
    var data =  await db?.query(table);
    var values = data?.map((e) => TaskModel.fromJson(e)).toList();
    return values;
  }

  Future<int?> deleteTodo(TaskModel taskModel) async {
    var db = await createDB();
    return await db?.delete(
      table,
      where: "_id = ?",
      whereArgs: [taskModel.id]
    );
  }
  Future<int?> deleteAllTodos() async {
    var db = await createDB();
    return await db?.delete(table);
  }
  Future<int?> updateTodo(TaskModel taskModel) async {
    var db = await createDB();
    return await db?.update(
        table,
        taskModel.toJson(),
        where: "_id = ?",
        whereArgs: [taskModel.id]
    );
  }

}