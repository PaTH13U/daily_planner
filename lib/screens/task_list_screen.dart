import 'package:daily_planner/screens/task_detail_screen.dart';
import 'package:daily_planner/screens/edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_service.dart';
import '../models/task.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách Công việc')),
      body: Consumer<TaskService>(
        builder: (context, taskService, child) {
          return ListView.builder(
            itemCount: taskService.tasks.length,
            itemBuilder: (context, index) {
              final task = taskService.tasks[index];
              return ListTile(
                title: Text(task.content),
                subtitle: Text(
                    '${task.date.toString().split(' ')[0]} - ${task.timeRange}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editTask(context, task),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTask(context, task.id),
                    ),
                  ],
                ),
                onTap: () => _viewTaskDetails(context, task),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addNewTask(context),
      ),
    );
  }

  void _addNewTask(BuildContext context) async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );
    if (newTask != null) {
      Provider.of<TaskService>(context, listen: false).addTask(newTask);
    }
  }

  void _editTask(BuildContext context, Task task) {
    Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (context) => EditTaskScreen(task: task)),
    ).then((editedTask) {
      if (editedTask != null) {
      Provider.of<TaskService>(context, listen: false).updateTask(editedTask);
      }
    });
  }

  void _deleteTask(BuildContext context, String taskId) {
    Provider.of<TaskService>(context, listen: false).deleteTask(taskId);
  }

  void _viewTaskDetails(BuildContext context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
    );
  }
}
