import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
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
      appBar: AppBar(title: Text('Chỉnh sửa Công việc')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Nội dung'),
            ),
            SizedBox(height: 10),
            Text('Ngày: ${widget.task.date.toString().split(' ')[0]}'),
            Text('Thời gian: ${widget.task.timeRange}'),
            SizedBox(height: 10),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Địa điểm'),
            ),
            TextFormField(
              controller: _organizerController,
              decoration: InputDecoration(labelText: 'Chủ trì'),
            ),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Ghi chú'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _status,
              decoration: InputDecoration(labelText: 'Trạng thái'),
              items: ['Tạo mới', 'Thực hiện', 'Thành công', 'Kết thúc']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
            ),
            TextFormField(
              initialValue: _reviewer,
              decoration: InputDecoration(labelText: 'Người kiểm duyệt'),
              onChanged: (value) {
                setState(() {
                  _reviewer = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Cập nhật công việc'),
              onPressed: _updateTask,
            ),
          ],
        ),
      ),
    );
  }

  void _updateTask() {
    final updatedTask = Task(
      id: widget.task.id,
      content: _contentController.text,
      date: widget.task.date,
      timeRange: widget.task.timeRange,
      location: _locationController.text,
      organizer: _organizerController.text,
      note: _noteController.text,
      status: _status,
      reviewer: _reviewer,
    );

    Provider.of<TaskService>(context, listen: false).updateTask(updatedTask);
    Navigator.pop(context);
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
