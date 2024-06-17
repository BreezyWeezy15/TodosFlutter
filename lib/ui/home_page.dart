import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:receive_intent/receive_intent.dart';
import 'package:todos_app/controller/todos_controller.dart';
import 'package:todos_app/ui/edit_task_page.dart';
import 'package:todos_app/utils.dart';
import 'details_page.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late TodosController _todosController;
  final List<String> _images = [
    "assets/images/personal.png",
    "assets/images/family.png",
    "assets/images/business.png"
  ];
  final List<String> _tabs = ["Personal","Family","Business"];
  int selectedTab = 0;
  @override
  void initState() {
    super.initState();
    _todosController = Get.put(TodosController());
    handlePermission();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(child: Text(
                      "Tasks", style: getBoldFont().copyWith(fontSize: 25),)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const TasksDetails())).then((value){
                             _todosController.getTodos(_tabs[selectedTab]);
                        });
                      },
                      child: const Icon(Icons.add, size: 30,),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () async {
                        // delete all items
                        showDialog(
                            context: context,
                            builder: (_){
                              return AlertDialog(
                                title: Text("Remove Tasks",style: getMedFont().copyWith(fontSize: 20),),
                                content: Text("Are you sure you want to remove all tasks?",style: getBoldFont().copyWith(fontSize: 17),),
                                actions: [
                                  ElevatedButton(onPressed: () async{
                                    int? result = await _todosController.deleteAllTasks();
                                    if(result! > 1){
                                      Fluttertoast.showToast(msg: "Tasks removed successfully");
                                       Alarm.getAlarms().clear();
                                      _todosController.getTodos("Personal");
                                      if(context.mounted) Navigator.pop(context);
                                    } else {
                                      Fluttertoast.showToast(msg: "Failed to remove tasks");
                                      if(context.mounted) Navigator.pop(context);
                                    }
                                  }, child: Text("Yes",style: getBoldFont(),)),
                                  ElevatedButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text("No",style: getBoldFont(),))
                                ],
                              );
                            });
                      },
                      child: const Icon(
                        Icons.delete_forever_rounded, size: 30,),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_tabs.length, (index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedTab = index;
                        });
                        _todosController.getTodos(_tabs[selectedTab]);
                      },
                      child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: selectedTab == index ?
                        Colors.green : Colors.green.shade300,
                      ),
                      child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                          Text(_tabs[index],style: getMedFont().copyWith(fontSize: 14,color:
                          selectedTab == index ?  Colors.white : Colors.black54),),
                          const Gap(5),
                          Image.asset(_images[index],width: 20,height: 20,color: Colors.white,)
                        ],
                      )),
                                            ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Obx(() {
                  if (_todosController.isLoading.value) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  else if (_todosController.error.value != null) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Center(
                        child: Text(_todosController.error.value!,style: getBoldFont().copyWith(fontSize: 25),),
                      ),
                    );
                  }
                  else if (_todosController.rxList.isNotEmpty) {
                    var data = _todosController.rxList;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) async {
                                // onDismiss
                                int? result = await _todosController.deleteTask(data[index]);
                                if(result == 1){
                                  await Alarm.stop(data[index].alarmID);
                                  Fluttertoast.showToast(msg: "Task successfully removed");
                                } else {
                                  Fluttertoast.showToast(msg: "Failed to remove task");
                                }
                              },
                              child: GestureDetector(
                                onTap: (){
                                  // edit values
                                  int? taskID = data[index].id;
                                  int alarmId = data[index].alarmID;
                                  String task = data[index].title;
                                  String date = data[index].date;
                                  String time = data[index].time;
                                  String color = data[index].color;
                                  String category = data[index].category;
                                  int colorIndex = data[index].colorIndex;
                                  int categoryIndex = data[index].categoryIndex;

                                  Navigator.push(context, MaterialPageRoute(builder: (_) =>  EditTaskPage(taskID : taskID! , alarmID: alarmId,
                                      task: task, date: date, time: time, color: color,category: category,
                                     selectedColorIndex: colorIndex,selectedCategoryIndex: categoryIndex,))).then((value){
                                       _todosController.getTodos(_tabs[selectedTab]);
                                  });
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  color: Color(hexStringToHexInt(data[index].color)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data[index].title, style: getBoldFont().copyWith(fontSize: 18, color: Colors.white),),
                                            Text("Date : ${data[index].date}", style: getMedFont().copyWith(fontSize: 15, color: Colors.white),),
                                            Text("Time : ${data[index].time}", style: getMedFont().copyWith(fontSize: 15, color: Colors.white),)
                                          ],
                                        )),
                                        GestureDetector(
                                          onTap: () async {
                                            showDialog(
                                                context: context,
                                                builder: (context){
                                                  return AlertDialog(
                                                    title: Text("Remove task",style: getBoldFont().copyWith(fontSize: 20),),
                                                    content: Text("Are you sure you want to remove task?",
                                                      style: getBoldFont().copyWith(fontSize: 20),),
                                                    actions: [
                                                      ElevatedButton(onPressed: () async {
                                                        int? result = await _todosController.deleteTask(data[index]!);
                                                        if(result == 1){
                                                          await Alarm.stop(data[index].alarmID);
                                                          Fluttertoast.showToast(msg: "Task successfully removed");
                                                          if(context.mounted) Navigator.pop(context);
                                                        } else {
                                                          Fluttertoast.showToast(msg: "Failed to remove task");
                                                          if(context.mounted) Navigator.pop(context);
                                                        }
                                                      }, child: Text("Yes",style: getBoldFont(),)),
                                                      ElevatedButton(onPressed: (){
                                                        Navigator.pop(context);
                                                      }, child: Text("No",style: getBoldFont(),))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: const Icon(
                                            Icons.delete_outline, size: 25,
                                            color: Colors.white,),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                      ),
                    );
                  }
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: Center(
                      child: Text("No Tasks Found",style: getBoldFont().copyWith(fontSize: 25)),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
  void handlePermission() async {
     var status  = await Permission.notification.status;
     if(status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied){
         Fluttertoast.showToast(msg: "Please grant permission");
         await Permission.notification.request();
     }
     else  if(status == PermissionStatus.granted){
       Fluttertoast.showToast(msg: "Permission Granted");
     }
  }
}
