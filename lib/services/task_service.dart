// lib/services/task_service.dart
import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskService with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void updateTaskStatus(String taskId, String newStatus, String reviewer) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    task.status = newStatus;
    task.reviewer = reviewer;
    notifyListeners();
  }
}