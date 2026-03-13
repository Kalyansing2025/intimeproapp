// ============================================================
// MODULE: Timesheet Management | SpecKit Specs: FR-TIME-001 to FR-TIME-005
// FR-TIME-001: Weekly timesheet view with week strip calendar
// FR-TIME-002: Show time entries for selected day
// FR-TIME-003: Display total hours per entry
// FR-TIME-004: Toggle between My Timesheet & Submitted view
// FR-TIME-005: Show billable/non-billable status per entry
// ============================================================
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/timesheet_model.dart';
import '../../widgets/dark_header.dart';

class TimesheetScreen extends StatefulWidget {
  const TimesheetScreen({super.key});

  @override
  State<TimesheetScreen> createState() => _TimesheetScreenState();
}

class _TimesheetScreenState extends State<TimesheetScreen> {
  bool _showMyTimesheet = true;
  DateTime _selectedDay = DateTime.now();
  late DateTime _weekStart;

  @override
  void initState() {
    super.initState();
    // get start of current week (Monday)
    final now = DateTime.now();
    _weekStart = now.subtract(Duration(days: now.weekday - 1));
    _selectedDay = now;
  }

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  Duration get _totalLogged => sampleTimesheetEntries
      .fold(Duration.zero, (s, e) => s + e.duration);

  Duration get _submitted => const Duration(hours: 20, minutes: 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          // Header
          DarkHeader(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu, color: Colors.white, size: 22),
                    const Text('Timesheet',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.statusOnline.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.statusOnline),
                      ),
                      child: Row(
                        children: const [
                          CircleAvatar(
                              radius: 4,
                              backgroundColor: AppColors.statusOnline),
                          SizedBox(width: 5),
                          Text('Online',
                              style: TextStyle(
                                  color: AppColors.statusOnline,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Logged / Submitted stats
                Row(
                  children: [
                    _TimeStatBox(
                      value: _formatDuration(_totalLogged),
                      label: AppStrings.loggedHours,
                    ),
                    const SizedBox(width: 16),
                    _TimeStatBox(
                      value: _formatDuration(_submitted),
                      label: AppStrings.submittedHours,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Toggle: My Timesheet / Submitted
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showMyTimesheet = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _showMyTimesheet
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(AppStrings.myTimesheet,
                              style: TextStyle(
                                color: _showMyTimesheet
                                    ? Colors.white
                                    : AppColors.textGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showMyTimesheet = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: !_showMyTimesheet
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(AppStrings.submitted,
                              style: TextStyle(
                                color: !_showMyTimesheet
                                    ? Colors.white
                                    : AppColors.textGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Week calendar strip
          _WeekStrip(
            weekStart: _weekStart,
            selectedDay: _selectedDay,
            onDayTap: (d) => setState(() => _selectedDay = d),
          ),
          const SizedBox(height: 8),

          // Timesheet entries
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: sampleTimesheetEntries.length,
              itemBuilder: (_, i) =>
                  _TimesheetCard(entry: sampleTimesheetEntries[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeStatBox extends StatelessWidget {
  final String value;
  final String label;

  const _TimeStatBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                letterSpacing: 1)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}

class _WeekStrip extends StatelessWidget {
  final DateTime weekStart;
  final DateTime selectedDay;
  final void Function(DateTime) onDayTap;

  const _WeekStrip({
    required this.weekStart,
    required this.selectedDay,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.calendar_today_outlined,
                color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (i) {
                  final day = weekStart.add(Duration(days: i));
                  final isToday = day.day == DateTime.now().day &&
                      day.month == DateTime.now().month;
                  final isSelected = day.day == selectedDay.day &&
                      day.month == selectedDay.month;
                  return GestureDetector(
                    onTap: () => onDayTap(day),
                    child: Column(
                      children: [
                        Text(days[i],
                            style: TextStyle(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textGrey,
                                fontSize: 10,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: isToday && !isSelected
                                ? Border.all(color: AppColors.primary)
                                : null,
                          ),
                          child: Center(
                            child: Text('${day.day}',
                                style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : isToday
                                            ? AppColors.primary
                                            : AppColors.textDark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(width: 8),
            Text('Today',
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _TimesheetCard extends StatelessWidget {
  final TimesheetEntry entry;

  const _TimesheetCard({required this.entry});

  String _formatHours(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    return '$h:$m hrs';
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
            color: Colors.black.withOpacity(0.04),
            blurRadius: 5,
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
              Text(entry.project,
                  style: const TextStyle(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
              Text(_formatHours(entry.duration),
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
            ],
          ),
          const SizedBox(height: 4),
          Text('Category: ${entry.category}',
              style:
                  const TextStyle(color: AppColors.textGrey, fontSize: 11)),
          const SizedBox(height: 2),
          Text('Task: ${entry.task}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(color: AppColors.textGrey, fontSize: 11)),
        ],
      ),
    );
  }
}
