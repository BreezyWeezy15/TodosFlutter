class TaskModel {
  static const String columnTaskId = "_id";
  static const String columnAlarmId = "_alarmId";
  static const String columnTaskTitle = "_title";
  static const String columnTaskDate = "_date";
  static const String columnTaskTime = "_time";
  static const String columnTimeStamp = "_timeStamp";
  static const String columnColor = "_color";
  static const String columnCategory = "_category";
  static const String columnColorIndex = "_colorIndex";
  static const String columnCategoryIndex = "_categoryIndex";

  int id;
  int alarmId;
  String title;
  String date;
  String time;
  int timeStamp;
  String color;
  String category;
  int colorIndex;
  int categoryIndex;

  TaskModel({
    required this.id,
    required this.alarmId,
    required this.title,
    required this.date,
    required this.time,
    required this.timeStamp,
    required this.color,
    required this.category,
    required this.colorIndex,
    required this.categoryIndex,
  });

  // Factory constructor to create a TaskModel from a JSON map
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json[columnTaskId] as int,
      alarmId: json[columnAlarmId] as int,
      title: json[columnTaskTitle] as String,
      date: json[columnTaskDate] as String,
      time: json[columnTaskTime] as String,
      timeStamp: json[columnTimeStamp] as int,
      color: json[columnColor] as String,
      category: json[columnCategory] as String,
      colorIndex: json[columnColorIndex] as int,
      categoryIndex: json[columnCategoryIndex] as int,
    );
  }

  // Method to convert a TaskModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      columnTaskId: id,
      columnAlarmId: alarmId,
      columnTaskTitle: title,
      columnTaskDate: date,
      columnTaskTime: time,
      columnTimeStamp: timeStamp,
      columnColor: color,
      columnCategory: category,
      columnColorIndex: colorIndex,
      columnCategoryIndex: categoryIndex,
    };
  }
}