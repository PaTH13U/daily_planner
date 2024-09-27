import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../services/task_service.dart';
import '../models/task.dart';
import 'task_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch Công việc')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) {
              return Provider.of<TaskService>(context, listen: false)
                  .tasks
                  .where((task) => isSameDay(task.date, day))
                  .toList();
            },
          ),
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    return Consumer<TaskService>(
      builder: (context, taskService, child) {
        final tasksForSelectedDay = taskService.tasks
            .where((task) => isSameDay(task.date, _selectedDay))
            .toList();

        return ListView.builder(
          itemCount: tasksForSelectedDay.length,
          itemBuilder: (context, index) {
            final task = tasksForSelectedDay[index];
            return ListTile(
              title: Text(task.content),
              subtitle: Text('${task.timeRange} - ${task.location}'),
              onTap: () => _viewTaskDetails(context, task),
            );
          },
        );
      },
    );
  }

  void _viewTaskDetails(BuildContext context, Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
    );
  }
}