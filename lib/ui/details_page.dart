import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/controller/todos_controller.dart';
import 'package:todos_app/models/task_model.dart';
import 'package:todos_app/notification_helper.dart';
import 'package:todos_app/utils.dart';

class TasksDetails extends StatefulWidget {
  const TasksDetails({super.key});

  @override
  State<TasksDetails> createState() => _TasksDetailsState();
}

class _TasksDetailsState extends State<TasksDetails> {
  late TodosController _todosController;
  var pickedDate = "";
  var pickedTime = "";
  var pickedColor = "";
  var pickedCategory = "";
  late DateTime dateStamp;
  late TimeOfDay timeStamp;
  var fullDate = 0;
  var selectedColorIndex = 0;
  var selectedCategoryIndex = 0;
  static final TextEditingController _taskController = TextEditingController();
  static final TextEditingController _dateController = TextEditingController();
  static final TextEditingController _timeController = TextEditingController();
  final List<String> _colors = ["#154a54", "#ff8f38", "#111827", "#ff4500", "#743747", "#467966"];
  final List<String> _images = [
    "assets/images/personal.png",
    "assets/images/family.png",
    "assets/images/business.png"
  ];
   final List<String> _categories = ["Personal","Family","Business"];
  @override
  void initState() {
    super.initState();
    _todosController = Get.find();
    NotificationHelper.initializePlatformSpecifics();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 15),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset("assets/images/arrow.png", width: 30, height: 30),
                    ),
                    const Gap(5),
                    Text("Add Task", style: getBoldFont().copyWith(fontSize: 35)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
                child: Text("Task Title", style: getMedFont().copyWith(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
                child: TextField(
                  controller: _taskController,
                  style: getMedFont().copyWith(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: "Task Title",
                    hintStyle: getMedFont(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Text("Task Date", style: getMedFont().copyWith(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
                child: TextField(
                  controller: _dateController,
                  readOnly: true,
                  style: getMedFont().copyWith(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: "Task Date",
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        var datePicked = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                          initialDate: DateTime.now(),
                          initialEntryMode: DatePickerEntryMode.calendar,
                        );
                        if (datePicked != null) {
                          setState(() {
                            pickedDate = formatDate(datePicked);
                            dateStamp = datePicked;
                          });
                          _dateController.text = pickedDate;
                        }
                      },
                      child: const Icon(Icons.date_range),
                    ),
                    hintStyle: getMedFont().copyWith(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Text("Task Time", style: getMedFont().copyWith(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
                child: TextField(
                  controller: _timeController,
                  style: getMedFont().copyWith(fontSize: 18),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: "Task Time",
                    hintStyle: getMedFont().copyWith(),
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        var timePicked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (timePicked != null) {
                          setState(() {
                            pickedTime = timePicked.format(context);
                            timeStamp = timePicked;
                          });
                          _timeController.text = pickedTime;
                        }
                      },
                      child: const Icon(Icons.lock_clock),
                    ),
                  ),
                ),
              ),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Text("Pick Your Task Color", style: getMedFont().copyWith(fontSize: 18)),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 20, top: 10),
                child: Row(
                  children: List<Widget>.generate(_colors.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          pickedColor = _colors[index];
                          selectedColorIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(hexStringToHexInt(_colors[index])),
                        ),
                        child: Center(
                          child: selectedColorIndex == index
                              ? const Icon(Icons.done, size: 30, color: Colors.white)
                              : Container(),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
                child: Text("Pick Category",style: getMedFont().copyWith(fontSize: 18),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
                child: Row(
                  children: List.generate(_categories.length, (index){
                    return  GestureDetector(
                      onTap: (){
                        setState(() {
                          pickedCategory =  _categories[index];
                          selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: selectedCategoryIndex == index ?
                            Border.all(color: Colors.deepOrange,width: 2) :
                            Border.all(color: Colors.transparent,width: 0),
                            color: Colors.blueGrey
                        ),
                        child: Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(_images[index],width: 40,height: 40,color: Colors.white,),
                            const Gap(5),
                            Text(_categories[index],style: getMedFont().copyWith(fontSize: 15,color: Colors.white),)
                          ],
                        ),),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const Gap(50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    var task = _taskController.text.toString();
                    var date = _dateController.text.toString();
                    var time = _timeController.text.toString();
                    if (task.isEmpty) {
                      Fluttertoast.showToast(msg: "Task cannot be empty");
                      return;
                    }
                    if (date.isEmpty) {
                      Fluttertoast.showToast(msg: "Date cannot be empty");
                      return;
                    }
                    if (time.isEmpty) {
                      Fluttertoast.showToast(msg: "Time cannot be empty");
                      return;
                    }
                    if (pickedColor.isEmpty) {
                      Fluttertoast.showToast(msg: "No color picked");
                      return;
                    }

                    var alarmId = int.parse(DateTime.now().microsecondsSinceEpoch.toString().substring(0,5));
                    TaskModel taskModel = TaskModel(
                      id: alarmId,
                      alarmId: alarmId,
                      title: task,
                      date: pickedDate,
                      time: pickedTime,
                      color: pickedColor,
                      timeStamp: combineDateTime(dateStamp, timeStamp).millisecondsSinceEpoch,
                      category: pickedCategory,
                      colorIndex: selectedColorIndex,
                      categoryIndex: selectedCategoryIndex
                    );

                    int? result = await _todosController.insertTask(taskModel);
                    if (result != 1) {
                      Fluttertoast.showToast(msg: "Task added successfully");
                      setState(() {
                        pickedColor = "";
                        selectedColorIndex = 0;
                        selectedCategoryIndex = 0;
                      });
                      await createAlarm(alarmId);
                    }
                    else {
                      Fluttertoast.showToast(msg: "Failed to add task");
                    }

                  },
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey,
                      ),
                      child: Center(
                        child: Text("Add Task", style: getMedFont().copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  String formatDate(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    var formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }
  DateTime combineDateTime(DateTime dateTime, TimeOfDay timeOfDay) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }
  Future createAlarm(int alarmID) async {
    final alarmSettings = AlarmSettings(
      id: alarmID,
      dateTime: combineDateTime(dateStamp, timeStamp),
      assetAudioPath: 'assets/audios/notification.mp3',
      loopAudio: false,
      vibrate: false,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: 'Task is ready!',
      notificationBody: _taskController.text.toString(),
      enableNotificationOnKill: Platform.isIOS,
    );
    await Alarm.set(alarmSettings: alarmSettings);
    _taskController.clear();
    _dateController.clear();
    _timeController.clear();
  }

}