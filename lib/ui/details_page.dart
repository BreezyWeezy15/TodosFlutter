import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todos_app/utils.dart';

class TasksDetails extends StatefulWidget {
  const TasksDetails({super.key});

  @override
  State<TasksDetails> createState() => _TasksDetailsState();
}

class _TasksDetailsState extends State<TasksDetails> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final List<String> _colors = ["#154a54","#ff8f38","#111827","#ff4500","#743747","#467966"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Add Task",style: getBoldFont().copyWith(fontSize: 35),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 50,top: 50),
              child: Text("Task Title",style: getMedFont().copyWith(fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 50,top: 5),
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  hintText: "Task Title",
                  hintStyle: getMedFont().copyWith()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 50,top: 20),
              child: Text("Task Date",style: getMedFont().copyWith(fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 50,top: 5),
              child: TextField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    hintText: "Task Date",
                    suffixIcon: GestureDetector(
                      onTap: (){},
                      child: const Icon(Icons.date_range),
                    ),
                    hintStyle: getMedFont().copyWith()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 50,top: 20),
              child: Text("Task Time",style: getMedFont().copyWith(fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 50,top: 5),
              child: TextField(
                controller: _timeController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    hintText: "Task Time",
                    hintStyle: getMedFont().copyWith(),
                    suffixIcon: GestureDetector(
                      onTap: (){},
                      child: const Icon(Icons.lock_clock),
                    )
                ),
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 50,top: 20),
              child: Text("Pick Your Task Color",style: getMedFont().copyWith(fontSize: 18),),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: List<Widget>.generate(_colors.length, (index){
                  return GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Color(hexStringToHexInt(_colors[index]))
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Gap(50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){},
                child: Center(
                  child: Container(
                    width: 200,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey
                    ),
                    child: Center(
                      child: Text("Add Task",style: getMedFont().copyWith(color: Colors.white),),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  hexStringToHexInt(String hex) {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }
}
