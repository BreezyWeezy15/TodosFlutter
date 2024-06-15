import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:todos_app/controller/todos_controller.dart';
import 'package:todos_app/utils.dart';

import 'details_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TodosController _todosController;

  @override
  void initState() {
    super.initState();
    _todosController = Get.put(TodosController());
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(child: Text("Tasks",style: getBoldFont().copyWith(fontSize: 25),)),
                    GestureDetector(
                      onTap: (){
                        // delete all items
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TasksDetails()));
                      },
                      child: const Icon(Icons.add,size: 30,),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: (){
                        // delete all items
                      },
                      child: const Icon(Icons.delete_forever_rounded,size: 30,),
                    )
                  ],
                ),
              ),
              Obx((){
                if(_todosController.isLoading.value){
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                else if (_todosController.error.value != null){
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text(_todosController.error.value!),
                    ),
                  );
                }
                else if (_todosController.rxList != null){
                  return Container();
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: Text("No Tasks Found"),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
