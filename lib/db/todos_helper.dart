
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodosHelper {
  static const String _databaseName = "todos.db";
  static const int _databaseVersion = 1;

  static const String table = "_todos";
  static const String columnID = "_id";
  static const String columnTaskTitle =  "_title";
  static const String columnTaskDate = "_date";
  static const String columnStatus = "_status";

  Database? _database;
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
  Future getTodos() async {

  }
  Future deleteTodo() async {

  }
  Future deleteAllTodos() async {

  }
  Future updateTodo() async {

  }

}