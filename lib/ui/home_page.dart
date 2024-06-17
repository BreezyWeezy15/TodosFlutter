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
    "assets/images/business.png",
    "assets/images/business.png"
  ];
  final List<String> _tabs = ["Personal","Family","Business","Others"];
  final List<String> _colors = ["#b4c5fe","#fff57f","#cff2e8","#ffc1f4"];
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
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
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
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black54
                        ),
                        child :  const Icon(Icons.add, size: 20,color: Colors.white,),
                      ),
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
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black54
                        ),
                        child :  const Icon(Icons.delete_forever_rounded, size: 20,color: Colors.white,),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 1.7,
                  ),
                  itemCount: _colors.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        _todosController.getTodos(_tabs[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(hexStringToHexInt(_colors[index])),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    width: 45,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                    ),
                                    child: Center(child: Image.asset(_images[index],width: 25,height: 25,),),
                                  ),
                                  const Gap(10),
                                  Text(_tabs[index],style: getMedFont().copyWith(fontSize: 18),)
                                ],
                              ),),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text("5",style: getMedFont().copyWith(fontSize: 23)),
                                ),
                              ),)
                          ],
                        ),
                      ),
                    );
                  },
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
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  color: Color(hexStringToHexInt(data[index].color)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
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
