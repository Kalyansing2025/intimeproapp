// ============================================================
// MODULE: Notifications | SpecKit Specs: FR-NOTIF-001 to FR-NOTIF-004
// FR-NOTIF-001: Show all notifications in chronological list
// FR-NOTIF-002: Visually distinguish unread notifications
// FR-NOTIF-003: Show different icon per notification type
// FR-NOTIF-004: Show timestamp per notification
// ============================================================
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/notification_model.dart';
import '../../widgets/dark_header.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  IconData _iconForType(NotificationType type) {
    switch (type) {
      case NotificationType.leaveApproved:
        return Icons.event_available;
      case NotificationType.meetingReminder:
        return Icons.video_call;
      case NotificationType.projectAssigned:
        return Icons.folder_special;
      case NotificationType.taskAssigned:
        return Icons.task_alt;
      case NotificationType.timesheetApproved:
        return Icons.access_time_filled;
    }
  }

  Color _colorForType(NotificationType type) {
    switch (type) {
      case NotificationType.leaveApproved:
        return const Color(0xFF8B5CF6);
      case NotificationType.meetingReminder:
        return const Color(0xFF3B82F6);
      case NotificationType.projectAssigned:
        return const Color(0xFFEF4444);
      case NotificationType.taskAssigned:
        return const Color(0xFF10B981);
      case NotificationType.timesheetApproved:
        return const Color(0xFF8B5CF6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: Column(
        children: [
          DarkHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu, color: Colors.white, size: 22),
                const Text('Notifications – Unread',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                TextButton(
                  onPressed: () {},
                  child: const Text('Clear All',
                      style: TextStyle(
                          color: AppColors.primary, fontSize: 13)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 10, bottom: 90),
              itemCount: sampleNotifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (_, i) {
                final n = sampleNotifications[i];
                return _NotificationCard(
                  notification: n,
                  icon: _iconForType(n.type),
                  iconColor: _colorForType(n.type),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final IconData icon;
  final Color iconColor;

  const _NotificationCard({
    required this.notification,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon circle
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title,
                    style: const TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
                const SizedBox(height: 3),
                Text(notification.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.textGrey, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(notification.timeAgo,
              style: const TextStyle(
                  color: AppColors.textLight, fontSize: 10)),
        ],
      ),
    );
  }
}
