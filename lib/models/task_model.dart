class TaskModel {
  static const String columnTaskId = "_id";
  static const String columnTaskTitle = "_title";
  static const String columnTaskDate = "_date";
  static const String columnTaskTime = "_time";
  static const String columnTimeStamp = "_timeStamp";
  static const String columnColor = "_color";

  int id;
  String title;
  String date;
  String time;
  int timeStamp;
  String color;

  TaskModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.timeStamp,
    required this.color,
  });

  // Factory constructor to create a TaskModel from a JSON map
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json[columnTaskId] as int,
      title: json[columnTaskTitle] as String,
      date: json[columnTaskDate] as String,
      time: json[columnTaskTime] as String,
      timeStamp: json[columnTimeStamp] as int,
      color: json[columnColor] as String,
    );
  }

  // Method to convert a TaskModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      columnTaskId: id,
      columnTaskTitle: title,
      columnTaskDate: date,
      columnTaskTime: time,
      columnTimeStamp: timeStamp,
      columnColor: color,
    };
  }
}