

import 'package:get/get.dart';
import 'package:todos_app/main.dart';
import 'package:todos_app/models/task_model.dart';

class TodosService {
   List<Map<String, Object?>>? _list = [];

   Future<List<TaskModel>?> getTodos() async {
     _list?.clear();
     _list = await todosHelper.getTodos();
     return _list?.map((e) => TaskModel.fromJson(e)).toList();
   }
   Future<int?> insertTask(TaskModel taskModel) async {
     return await todosHelper.insertTodo(taskModel);
   }
   Future<int?> deleteTask(TaskModel taskModel) async {
      return await todosHelper.deleteTodo(taskModel);
   }
   Future<int?> updateTask(TaskModel taskModel) async {
      return await todosHelper.updateTodo(taskModel);
   }
   Future<int?> deleteAllTasks() async {
     return await todosHelper.deleteAllTodos();
   }
}