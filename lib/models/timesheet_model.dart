class TimesheetEntry {
  final String project;
  final String category;
  final String task;
  final Duration duration;
  final DateTime date;

  TimesheetEntry({
    required this.project,
    required this.category,
    required this.task,
    required this.duration,
    required this.date,
  });
}

final List<TimesheetEntry> sampleTimesheetEntries = [
  TimesheetEntry(
    project: 'AAA Platform',
    category: 'DevOps & Release Management',
    task: 'Addition / Deletion for corporate pdi...',
    duration: const Duration(hours: 2, minutes: 33),
    date: DateTime(2024, 5, 12),
  ),
  TimesheetEntry(
    project: 'Bon Ton',
    category: 'BackEnd Development',
    task: 'Bug fix #3256 - Customer screen requires valid...',
    duration: const Duration(hours: 5, minutes: 21),
    date: DateTime(2024, 5, 12),
  ),
];
