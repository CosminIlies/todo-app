import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoModel {
  String id;
  String title;
  String description;
  int priority;
  DateTime dueDate;
  bool isDone;

  TodoModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.priority,
      required this.dueDate,
      required this.isDone});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      dueDate: DateTime.parse(json['dueDate']),
      isDone: json['isDone'],
    );
  }

  factory TodoModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return TodoModel(
      id: document.id,
      title: data['title'],
      description: data['description'],
      priority: data['priority'],
      dueDate: data['dueDate'].toDate(),
      isDone: data['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'dueDate': dueDate.toIso8601String(),
      'isDone': isDone,
    };
  }

  String priorityStr() {
    if (priority == 0) {
      return 'Low';
    } else if (priority == 1) {
      return 'Medium';
    } else {
      return 'High';
    }
  }

  Color priorityColor() {
    if (priority == 0) {
      return Color(0xff00ff00);
    } else if (priority == 1) {
      return Color(0xffffff00);
    } else {
      return Color(0xffff0000);
    }
  }

  bool isOverdue() {
    return dueDate.isBefore(DateTime.now());
  }

  String dueDateStr() {
    DateTime now = DateTime.now();
    DateTime due = dueDate;

    Duration dif = due.difference(now);
    if (dif.inDays > 0) {
      return "${dif.inDays} d";
    } else if (dif.inHours > 0) {
      return "${dif.inHours} h";
    } else if (dif.inMinutes > 0) {
      return "${dif.inMinutes} m";
    } else if (dif.inMinutes > 0) {
      return "${dif.inSeconds} s";
    }

    return "Overdue";
  }
}
