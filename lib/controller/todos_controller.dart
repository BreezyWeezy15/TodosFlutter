import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../auth/todos_service.dart';
import '../models/task_model.dart';

class TodosController extends GetxController {
  final TodosService _todosService = TodosService();
  RxList<TaskModel> rxList = RxList<TaskModel>();
  Rx<bool> isLoading = Rx(false);

  void getTodos(String category) async {
    rxList.clear();
    isLoading.value = true;
    var data = await _todosService.getTodos(category);
    if (data!.isEmpty) {
      isLoading.value = false;
    } else {
      rxList.addAll(data!);
      rxList.refresh();
      isLoading.value = false;
    }


  }
  Future<int?> insertTask(TaskModel taskModel) async {
    return await _todosService.insertTask(taskModel);
  }
  Future<int?> deleteTask(TaskModel taskModel) async {
    return await _todosService.deleteTask(taskModel);
  }
  Future<int?> updateTask(TaskModel taskModel) async {
    return await _todosService.updateTask(taskModel);
  }
  Future<int?> deleteAllTasks() async {
    return await _todosService.deleteAllTasks();
  }

}