enum LeaveStatus { pending, approved }
enum LeaveType { vacation, casualLeave, sick, parental }

class LeaveModel {
  final String id;
  final LeaveType type;
  final DateTime startDate;
  final DateTime endDate;
  final int days;
  final LeaveStatus status;

  LeaveModel({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.status,
  });

  String get typeLabel {
    switch (type) {
      case LeaveType.vacation:
        return 'Vacation';
      case LeaveType.casualLeave:
        return 'Casual Leave';
      case LeaveType.sick:
        return 'Sick';
      case LeaveType.parental:
        return 'Parental';
    }
  }
}

final List<LeaveModel> sampleLeaves = [
  LeaveModel(
    id: '1',
    type: LeaveType.vacation,
    startDate: DateTime(2024, 3, 28),
    endDate: DateTime(2024, 3, 29),
    days: 3,
    status: LeaveStatus.pending,
  ),
  LeaveModel(
    id: '2',
    type: LeaveType.casualLeave,
    startDate: DateTime(2024, 2, 16),
    endDate: DateTime(2024, 2, 16),
    days: 1,
    status: LeaveStatus.approved,
  ),
  LeaveModel(
    id: '3',
    type: LeaveType.sick,
    startDate: DateTime(2023, 7, 12),
    endDate: DateTime(2023, 12, 10),
    days: 4,
    status: LeaveStatus.approved,
  ),
  LeaveModel(
    id: '4',
    type: LeaveType.parental,
    startDate: DateTime(2023, 7, 12),
    endDate: DateTime(2023, 12, 10),
    days: 2,
    status: LeaveStatus.approved,
  ),
  LeaveModel(
    id: '5',
    type: LeaveType.vacation,
    startDate: DateTime(2024, 3, 28),
    endDate: DateTime(2024, 3, 29),
    days: 1,
    status: LeaveStatus.pending,
  ),
];
