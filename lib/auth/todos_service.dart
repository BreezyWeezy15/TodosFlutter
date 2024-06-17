

import 'package:get/get.dart';
import 'package:todos_app/main.dart';
import 'package:todos_app/models/task_model.dart';

class TodosService {

   Future<List<TaskModel>?> getTodos(String category) async {
     return await todosHelper.getTodos(category);
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