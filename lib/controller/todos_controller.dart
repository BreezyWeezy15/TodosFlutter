import 'package:get/get.dart';
import 'package:todos_app/auth/todos_service.dart';
import 'package:todos_app/models/task_model.dart';

class TodosController extends GetxController {
  final TodosService _todosService = TodosService();
  final RxList<TaskModel?>? rxList = RxList();
  Rx<bool> isLoading = Rx(false);
  Rx<String?> error = Rx(null);

  @override
  void onInit() {
    super.onInit();
    _getTodos();
  }
  void _getTodos() {
      isLoading.value = true;
      try {
        _todosService.getTodos().then((value){
          if(value != null){
            rxList?.value = value;
            isLoading.value = false;
          }
          isLoading.value = false;
        });
      } catch(e){
        isLoading.value = false;
        error.value = e.toString();
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