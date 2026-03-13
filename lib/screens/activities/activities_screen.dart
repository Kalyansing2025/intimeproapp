// ============================================================
// MODULE: Task Management (Activities) | SpecKit Specs: FR-TASK-001 to FR-TASK-005
// FR-TASK-001: Show all tasks in a list
// FR-TASK-002: Show task status visually with colors
// FR-TASK-003: Search/filter tasks by name
// FR-TASK-004: Show billable/non-billable indicator
// FR-TASK-005: Show elapsed time per task
// ============================================================
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../models/task_model.dart';
import '../../widgets/task_card.dart';
import '../../widgets/dark_header.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: Column(
        children: [
          const SimpleHeader(title: 'Activities'),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 4, bottom: 90),
              itemCount: sampleTasks.length,
              itemBuilder: (_, i) => TaskCard(task: sampleTasks[i]),
            ),
          ),
        ],
      ),
    );
  }
}
