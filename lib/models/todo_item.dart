//import 'package:flutter/material.dart';

class TodoItem {
  int id = -1;
  String title;
  String description;
  DateTime deadline = DateTime.now();
  bool done = false;

  TodoItem(
      {this.id = -1,
      required this.title,
      this.description = "",
      required this.deadline,
      this.done = false});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline.millisecondsSinceEpoch,
      'done': done ? 1 : 0,
    };
  }
}
