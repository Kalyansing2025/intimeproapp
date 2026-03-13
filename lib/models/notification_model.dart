enum NotificationType {
  leaveApproved,
  meetingReminder,
  projectAssigned,
  taskAssigned,
  timesheetApproved,
}

class NotificationModel {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime time;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    this.isRead = false,
  });

  String get timeAgo {
    final diff = DateTime.now().difference(time);
    if (diff.inHours >= 1) return '${diff.inHours} hr ago';
    if (diff.inMinutes >= 1) return '${diff.inMinutes} mins ago';
    return 'Just now';
  }
}

final List<NotificationModel> sampleNotifications = [
  NotificationModel(
    id: '1',
    type: NotificationType.leaveApproved,
    title: 'Leave Approved!',
    body: 'Your Leave From 13 February 2024 To 15 February 2024 has been Approved.',
    time: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  NotificationModel(
    id: '2',
    type: NotificationType.meetingReminder,
    title: 'Meeting Reminder!',
    body: 'ITP - Scrum Call is schedule on 11:00 am to 11:30 am with 9 members on Te...',
    time: DateTime.now().subtract(const Duration(minutes: 47)),
  ),
  NotificationModel(
    id: '3',
    type: NotificationType.projectAssigned,
    title: 'New Project Assigned!',
    body: 'You have been assigned to "Space AI" from 16 February 2024 as an "UX Desi...',
    time: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
  NotificationModel(
    id: '4',
    type: NotificationType.taskAssigned,
    title: 'New Task Assigned!',
    body: 'You have been assigned to "Space AI" from 16 February 2024 as an "UX Desi...',
    time: DateTime.now().subtract(const Duration(minutes: 4)),
  ),
  NotificationModel(
    id: '5',
    type: NotificationType.timesheetApproved,
    title: 'Timesheet Approved!',
    body: 'Your timesheet From 5 February 2024 To 12 February 2024 has been approv...',
    time: DateTime.now().subtract(const Duration(hours: 15)),
  ),
  NotificationModel(
    id: '6',
    type: NotificationType.projectAssigned,
    title: 'New Project Assigned!',
    body: 'You have been assigned to "Space AI" from 12 February 2024 as an "UX Desi...',
    time: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
];
