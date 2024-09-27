import 'package:daily_planner/screens/edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController _contentController;
  late TextEditingController _locationController;
  late TextEditingController _organizerController;
  late TextEditingController _noteController;
  late String _status;
  late String _reviewer;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.task.content);
    _locationController = TextEditingController(text: widget.task.location);
    _organizerController = TextEditingController(text: widget.task.organizer);
    _noteController = TextEditingController(text: widget.task.note);
    _status = widget.task.status;
    _reviewer = widget.task.reviewer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết Công việc')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nội dung: ${widget.task.content}'),
            const SizedBox(height: 8.0),
            Text('Địa điểm: ${widget.task.location}'),
            const SizedBox(height: 8.0),
            Text('Người tổ chức: ${widget.task.organizer}'),
            const SizedBox(height: 8.0),
            Text('Ghi chú: ${widget.task.note}'),
            const SizedBox(height: 8.0),
            Text('Trạng thái: ${widget.task.status}'),
            const SizedBox(height: 8.0),
            Text('Người kiểm duyệt: ${widget.task.reviewer}'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(task: widget.task),
                  ),
                );
              },
              child: const Text('Chỉnh sửa'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    _locationController.dispose();
    _organizerController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
