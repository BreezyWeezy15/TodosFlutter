class TaskModel {
  static const String columnTaskId = "_id";
  static const String columnAlarmID = "_alarmID";
  static const String columnTaskTitle = "_title";
  static const String columnTaskDate = "_date";
  static const String columnTaskTime = "_time";
  static const String columnColor = "_color";
  static const String columnTimeStamp = "_timeStamp";
  static const String columnCategory = "_category";
  static const String columnColorIndex = "_colorIndex";
  static const String columnCategoryIndex = "_categoryIndex";

  int? id;
  int alarmID;
  String title;
  String date;
  String time;
  String color;
  int timeStamp;
  String category;
  int colorIndex;
  int categoryIndex;

  TaskModel({
    this.id,
    required this.alarmID,
    required this.title,
    required this.date,
    required this.time,
    required this.color,
    required this.timeStamp,
    required this.category,
    required this.colorIndex,
    required this.categoryIndex,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnAlarmID: alarmID,
      columnTaskTitle: title,
      columnTaskDate: date,
      columnTaskTime: time,
      columnColor: color,
      columnTimeStamp: timeStamp,
      columnCategory: category,
      columnColorIndex: colorIndex,
      columnCategoryIndex: categoryIndex,
    };
    if (id != null) {
      map[columnTaskId] = id;
    }
    return map;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map[columnTaskId],
      alarmID: map[columnAlarmID],
      title: map[columnTaskTitle],
      date: map[columnTaskDate],
      time: map[columnTaskTime],
      color: map[columnColor],
      timeStamp: map[columnTimeStamp],
      category: map[columnCategory],
      colorIndex: map[columnColorIndex],
      categoryIndex: map[columnCategoryIndex],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      columnTaskId: id,
      columnAlarmID: alarmID,
      columnTaskTitle: title,
      columnTaskDate: date,
      columnTaskTime: time,
      columnColor: color,
      columnTimeStamp: timeStamp,
      columnCategory: category,
      columnColorIndex: colorIndex,
      columnCategoryIndex: categoryIndex,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json[columnTaskId],
      alarmID: json[columnAlarmID],
      title: json[columnTaskTitle],
      date: json[columnTaskDate],
      time: json[columnTaskTime],
      color: json[columnColor],
      timeStamp: json[columnTimeStamp],
      category: json[columnCategory],
      colorIndex: json[columnColorIndex],
      categoryIndex: json[columnCategoryIndex],
    );
  }
}
