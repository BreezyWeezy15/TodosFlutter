
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todos_app/controller/todos_controller.dart';
import 'package:todos_app/models/task_model.dart';

class TodosHelper {
  static const String _databaseName = "todos.db";
  static const int _databaseVersion = 1;

  static const String table = "_todos";
  static const String columnID = "_id";
  static const String columnTaskTitle =  "_title";
  static const String columnTaskDate = "_date";
  static const String columnStatus = "_status";

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
     String path = join(databasePath + _databaseName,);
     return await openDatabase(path,version: _databaseVersion,onCreate: (db,version) async {
       await db.execute('''
          CREATE TABLE $table (
            $columnID INTEGER PRIMARY KEY,
            $columnTaskTitle TEXT NOT NULL,
            $columnTaskDate TEXT NOT NULL,
            $columnStatus INTEGER NOT NULL,
          )
          ''');
     });
  }
  Future<int?> insertTodo(TaskModel taskModel) async {
     var db = await createDB();
     return await db?.insert(table, taskModel.toJson());
  }
  Future<List<Map<String, Object?>>?> getTodos() async {
    var db = await createDB();
    return await db?.query(table);
  }
  Future<int?> deleteTodo(TaskModel taskModel) async {
    var db = await createDB();
    return await db?.delete(
      table,
      where: "columnID = ?",
      whereArgs: [taskModel.id]
    );
  }
  Future<int?> deleteAllTodos() async {
    var db = await createDB();
    return await db?.delete(table);
  }
  Future<int?> updateTodo(TaskModel taskModel) async {
    var db = await createDB();
    return await db?.update(table, taskModel.toJson());
  }

}