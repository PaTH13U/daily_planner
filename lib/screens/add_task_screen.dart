import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _content;
  late DateTime _date;
  TimeOfDay _startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 11, minute: 0);
  late String _location;
  late String _organizer;
  String _note = '';
  final String _status = 'Tạo mới';

  @override
  void initState() {
    super.initState();
    _date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thêm Công việc mới')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Nội dung công việc'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập nội dung công việc';
                }
                return null;
              },
              onSaved: (value) => _content = value!,
            ),
            ListTile(
              title: Text('Ngày: ${DateFormat('dd/MM/yyyy').format(_date)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: _selectDate,
            ),
            _buildTimeRangePicker(),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Địa điểm'),
              onSaved: (value) => _location = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Chủ trì'),
              onSaved: (value) => _organizer = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Ghi chú'),
              maxLines: 3,
              onSaved: (value) => _note = value!,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Thêm Công việc'),
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangePicker() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text('Bắt đầu: ${_startTime.format(context)}'),
            trailing: const Icon(Icons.access_time),
            onTap: () => _selectTime(isStartTime: true),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text('Kết thúc: ${_endTime.format(context)}'),
            trailing: const Icon(Icons.access_time),
            onTap: () => _selectTime(isStartTime: false),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _selectTime({required bool isStartTime}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newTask = Task(
        id: DateTime.now().toString(),
        content: _content,
        date: _date,
        timeRange:
            '${_startTime.format(context)} - ${_endTime.format(context)}',
        location: _location,
        organizer: _organizer,
        note: _note,
        status: _status,
      );
      Navigator.pop(context, newTask);
    }
  }
}
