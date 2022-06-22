// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  Task({
    required this.body,
    required this.createdAt,
    required this.completed,
    required this.category,
  });

  String body;
  DateTime createdAt;
  bool completed;
  String category;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        body: json["body"],
        createdAt: json["created_at"],
        completed: json["completed"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "created_at": createdAt,
        "completed": completed,
        "category": category,
      };
}
