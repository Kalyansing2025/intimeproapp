// ============================================================
// MODULE: Project Management | SpecKit Specs: FR-PROJ-001 to FR-PROJ-004
// FR-PROJ-001: Show list of all projects
// FR-PROJ-002: Display project completion percentage (progress bar)
// FR-PROJ-003: Display project start and end dates
// FR-PROJ-004: Display team member avatars per project
// ============================================================
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/project_model.dart';
import '../../widgets/dark_header.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: Column(
        children: [
          // Header
          SimpleHeader(title: AppStrings.projects),

          // Stats row
          Container(
            color: const Color(0xFF0F3460),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Row(
              children: [
                _ProjectStat(
                  value: '${sampleProjects.length}',
                  label: AppStrings.totalProjects,
                ),
                const SizedBox(width: 24),
                _ProjectStat(
                  value: '${sampleProjects.fold(0, (s, p) => s + p.totalTasks)}',
                  label: AppStrings.totalTasks,
                ),
              ],
            ),
          ),

          // Project list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 90),
              itemCount: sampleProjects.length,
              itemBuilder: (_, i) => _ProjectCard(project: sampleProjects[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProjectStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700)),
        Text(label,
            style:
                const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  Color _progressColor(double p) {
    if (p >= 0.85) return AppColors.tabCompleted;
    if (p >= 0.5) return AppColors.primary;
    return AppColors.statusNonBillable;
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('MMM dd, yyyy');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
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
            children: [
              // Logo
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.lightBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(project.logoEmoji ?? '📁',
                      style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 12),

              // Name + team members
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.name,
                        style: const TextStyle(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                    const SizedBox(height: 4),
                    // Team member avatars
                    Row(
                      children: [
                        ...List.generate(
                          project.teamMembers.length > 4
                              ? 4
                              : project.teamMembers.length,
                          (i) => Align(
                            widthFactor: 0.7,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: _avatarColor(i),
                              child: Text(
                                project.teamMembers[i].name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        if (project.teamMemberCount > 4) ...[
                          const SizedBox(width: 8),
                          Text(
                            '+${project.teamMemberCount - 4}',
                            style: const TextStyle(
                                color: AppColors.textGrey, fontSize: 11),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Progress %
              Text(
                '${(project.progressPercent * 100).toInt()}%',
                style: TextStyle(
                  color: _progressColor(project.progressPercent),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: project.progressPercent,
              backgroundColor: AppColors.divider,
              color: _progressColor(project.progressPercent),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),

          // Dates & tasks row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Start Date',
                        style: TextStyle(
                            color: AppColors.textGrey, fontSize: 10)),
                    Text(fmt.format(project.startDate),
                        style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('End Date',
                        style: TextStyle(
                            color: AppColors.textGrey, fontSize: 10)),
                    Text(fmt.format(project.endDate),
                        style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Team Members',
                      style: TextStyle(
                          color: AppColors.textGrey, fontSize: 10)),
                  Text('${project.totalTasks}',
                      style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _avatarColor(int index) {
    const colors = [
      Color(0xFF4A90D9),
      Color(0xFFE91E8C),
      Color(0xFF22C55E),
      Color(0xFF8B5CF6),
    ];
    return colors[index % colors.length];
  }
}
