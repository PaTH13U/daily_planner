class Task {
  String id;
  String content;
  DateTime date;
  String timeRange;
  String location;
  String organizer;
  String note;
  String status;
  String reviewer;

  Task({
    required this.id,
    required this.content,
    required this.date,
    required this.timeRange,
    required this.location,
    required this.organizer,
    this.note = '',
    this.status = 'Tạo mới',
    this.reviewer = '',
  });
}
