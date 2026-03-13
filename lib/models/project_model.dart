class TeamMember {
  final String name;
  final String avatarColor;

  TeamMember({required this.name, required this.avatarColor});
}

class ProjectModel {
  final String id;
  final String name;
  final String? logoEmoji;
  final String logoColor;
  final DateTime startDate;
  final DateTime endDate;
  final int totalTasks;
  final int teamMemberCount;
  final double progressPercent;
  final List<TeamMember> teamMembers;

  ProjectModel({
    required this.id,
    required this.name,
    this.logoEmoji,
    required this.logoColor,
    required this.startDate,
    required this.endDate,
    required this.totalTasks,
    required this.teamMemberCount,
    required this.progressPercent,
    required this.teamMembers,
  });
}

final List<ProjectModel> sampleProjects = [
  ProjectModel(
    id: '1',
    name: 'AAA Academy',
    logoEmoji: '🎓',
    logoColor: '#E8F4FD',
    startDate: DateTime(2023, 2, 27),
    endDate: DateTime(2024, 4, 15),
    totalTasks: 18,
    teamMemberCount: 14,
    progressPercent: 0.65,
    teamMembers: [
      TeamMember(name: 'A', avatarColor: '#4A90D9'),
      TeamMember(name: 'B', avatarColor: '#E91E8C'),
      TeamMember(name: 'C', avatarColor: '#22C55E'),
    ],
  ),
  ProjectModel(
    id: '2',
    name: 'Raaghu',
    logoEmoji: '⚡',
    logoColor: '#FFF3E0',
    startDate: DateTime(2023, 2, 27),
    endDate: DateTime(2024, 4, 15),
    totalTasks: 9,
    teamMemberCount: 8,
    progressPercent: 0.83,
    teamMembers: [
      TeamMember(name: 'R', avatarColor: '#8B5CF6'),
      TeamMember(name: 'S', avatarColor: '#F59E0B'),
      TeamMember(name: 'T', avatarColor: '#EF4444'),
    ],
  ),
  ProjectModel(
    id: '3',
    name: 'Bon Ton',
    logoEmoji: '🛍️',
    logoColor: '#F3E8FF',
    startDate: DateTime(2023, 10, 17),
    endDate: DateTime(2024, 2, 15),
    totalTasks: 7,
    teamMemberCount: 5,
    progressPercent: 0.90,
    teamMembers: [
      TeamMember(name: 'M', avatarColor: '#10B981'),
      TeamMember(name: 'N', avatarColor: '#3B82F6'),
      TeamMember(name: 'O', avatarColor: '#EC4899'),
    ],
  ),
];
