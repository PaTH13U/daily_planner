import 'package:daily_planner/screens/task_detail_screen.dart';
import 'package:daily_planner/screens/edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../services/task_service.dart';
import '../models/task.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Công việc'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Consumer<TaskService>(
        builder: (context, taskService, child) {
          return taskService.tasks.isEmpty
              ? const Center(
                  child: Text('Chưa có công việc nào. Thêm công việc mới!'))
              : ListView.builder(
                  itemCount: taskService.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskService.tasks[index];
                    return _buildTaskCard(context, task);
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => _addNewTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Task task) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(task.status),
          child: const Icon(Icons.assignment, color: Colors.white),
        ),
        title: Text(
          task.content,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${DateFormat('dd/MM/yyyy').format(task.date)} - ${task.timeRange}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 2),
            Text(
              task.location,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _editTask(context, task);
                break;
              case 'delete':
                _deleteTask(context, task.id);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Chỉnh sửa'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Xóa'),
              ),
            ),
          ],
        ),
        onTap: () => _viewTaskDetails(context, task),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Tạo mới':
        return Colors.blue;
      case 'Đang thực hiện':
        return Colors.orange;
      case 'Hoàn thành':
        return Colors.green;
      default:
        return Colors.grey;
    }
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
