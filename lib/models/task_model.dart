class TaskModel {
  static const String columnTaskId = "_id";
  static const String columnTaskTitle = "_title";
  static const String columnTaskDate = "_date";
  static const String columnStatus = "_status";

  int id;
  String title;
  String date;
  String status;

  TaskModel({required this.id, required this.title, required this.date, required this.status});

  // Factory constructor to create a TaskModel from a JSON map
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json[columnTaskId] as int,
      title: json[columnTaskTitle] as String,
      date: json[columnTaskDate] as String,
      status: json[columnStatus] as String,
    );
  }

  // Method to convert a TaskModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      columnTaskId: id,
      columnTaskTitle: title,
      columnTaskDate: date,
      columnStatus: status,
    };
  }
}
