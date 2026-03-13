import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Color get _statusColor {
    switch (task.status) {
      case TaskStatus.newTask:
        return AppColors.tabNew;
      case TaskStatus.inProgress:
        return AppColors.tabInProgress;
      case TaskStatus.overdue:
        return AppColors.tabOverdue;
      case TaskStatus.completed:
        return AppColors.tabCompleted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(task.project,
                    style: const TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (task.isBillable
                          ? AppColors.statusBillable
                          : AppColors.statusNonBillable)
                      .withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: task.isBillable
                        ? AppColors.statusBillable
                        : AppColors.statusNonBillable,
                  ),
                ),
                child: Text(
                  task.isBillable ? 'Billable' : 'Non Billable',
                  style: TextStyle(
                    color: task.isBillable
                        ? AppColors.statusBillable
                        : AppColors.statusNonBillable,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(task.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(task.elapsed),
                style: TextStyle(
                  color: _statusColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              if (task.status != TaskStatus.completed)
                Row(
                  children: [
                    _ActionIcon(
                      icon: Icons.play_arrow,
                      color: AppColors.statusOnline,
                    ),
                    const SizedBox(width: 8),
                    _ActionIcon(
                      icon: Icons.stop,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    _ActionIcon(
                      icon: Icons.check,
                      color: AppColors.tabInProgress,
                    ),
                  ],
                )
              else
                const Icon(Icons.check_circle,
                    color: AppColors.tabCompleted, size: 24),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _ActionIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Icon(icon, color: color, size: 16),
    );
  }
}
