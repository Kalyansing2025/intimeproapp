enum TaskStatus { newTask, inProgress, overdue, completed }

class TaskModel {
  final String id;
  final String title;
  final String project;
  final String category;
  final TaskStatus status;
  final Duration elapsed;
  final Duration? estimated;
  final bool isBillable;

  TaskModel({
    required this.id,
    required this.title,
    required this.project,
    required this.category,
    required this.status,
    required this.elapsed,
    this.estimated,
    this.isBillable = true,
  });
}

// Sample data
final List<TaskModel> sampleTasks = [
  TaskModel(
    id: '1',
    title: 'Bug fix #3256 - Customer screen requires validation for lookup value for city, state, zip, C...',
    project: 'Raaghu',
    category: 'BackEnd Development',
    status: TaskStatus.inProgress,
    elapsed: const Duration(hours: 4, minutes: 18, seconds: 22),
    estimated: const Duration(hours: 6),
    isBillable: false,
  ),
  TaskModel(
    id: '2',
    title: 'Feature #204 - As a Manager, Program Manager, Admin, I want to live stream users that are alloc...',
    project: 'AAA Platform',
    category: 'DevOps & Release Management',
    status: TaskStatus.newTask,
    elapsed: const Duration(hours: 2, minutes: 4, seconds: 35),
    estimated: const Duration(hours: 4),
    isBillable: true,
  ),
  TaskModel(
    id: '3',
    title: 'Bug fix #3256 - Customer screen requires validation for lookup value for city, state, zip, C...',
    project: 'Raaghu',
    category: 'BackEnd Development',
    status: TaskStatus.overdue,
    elapsed: const Duration(hours: 5, minutes: 21),
    estimated: const Duration(hours: 4),
    isBillable: false,
  ),
  TaskModel(
    id: '4',
    title: 'High Fidelity Wireframe - Design mockup for dashboard screen completed and reviewed',
    project: 'Bon Ton',
    category: 'UI/UX Design',
    status: TaskStatus.completed,
    elapsed: const Duration(hours: 3, minutes: 45),
    isBillable: true,
  ),
];
