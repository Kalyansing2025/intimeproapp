// ============================================================
// MODULE: Leave Management | SpecKit Specs: FR-LEAVE-001 to FR-LEAVE-005
// FR-LEAVE-001: Show all leave requests in a list
// FR-LEAVE-002: Show leave status with colors (Approved/Pending/Rejected)
// FR-LEAVE-003: Apply for new leave via bottom sheet form
// FR-LEAVE-004: Select leave type from dropdown
// FR-LEAVE-005: Select date range for leave
// ============================================================
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_colors.dart';
import '../../models/leave_model.dart';
import '../../widgets/dark_header.dart';

class LeavesScreen extends StatefulWidget {
  const LeavesScreen({super.key});

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  void _showApplyLeaveDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _ApplyLeaveSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      floatingActionButton: FloatingActionButton(
        onPressed: _showApplyLeaveDialog,
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
                    const Text('Leaves',
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
                const SizedBox(height: 16),
                // Leave balance stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _LeaveStatItem(value: '2', label: 'Available\nBalance'),
                    _LeaveStatItem(value: '4', label: 'Currently\nBooked'),
                    _LeaveStatItem(value: '18', label: 'Annual\nBalance'),
                  ],
                ),
              ],
            ),
          ),

          // Leave list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 100),
              itemCount: sampleLeaves.length,
              itemBuilder: (_, i) => _LeaveCard(leave: sampleLeaves[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaveStatItem extends StatelessWidget {
  final String value;
  final String label;

  const _LeaveStatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700)),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}

class _LeaveCard extends StatelessWidget {
  final LeaveModel leave;

  const _LeaveCard({required this.leave});

  IconData get _icon {
    switch (leave.type) {
      case LeaveType.vacation:
        return Icons.beach_access;
      case LeaveType.casualLeave:
        return Icons.wb_sunny;
      case LeaveType.sick:
        return Icons.local_hospital;
      case LeaveType.parental:
        return Icons.child_care;
    }
  }

  Color get _iconColor {
    switch (leave.type) {
      case LeaveType.vacation:
        return const Color(0xFF4A90D9);
      case LeaveType.casualLeave:
        return const Color(0xFFF59E0B);
      case LeaveType.sick:
        return const Color(0xFFEF4444);
      case LeaveType.parental:
        return const Color(0xFF22C55E);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd/MM/yyyy');
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
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_icon, color: _iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(leave.typeLabel,
                        style: const TextStyle(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                    Text('${leave.days} Days',
                        style: const TextStyle(
                            color: AppColors.textGrey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${fmt.format(leave.startDate)} – ${fmt.format(leave.endDate)}',
                      style: const TextStyle(
                          color: AppColors.textGrey, fontSize: 11),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: (leave.status == LeaveStatus.approved
                                ? AppColors.statusApproved
                                : AppColors.statusPending)
                            .withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 3,
                            backgroundColor: leave.status == LeaveStatus.approved
                                ? AppColors.statusApproved
                                : AppColors.statusPending,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            leave.status == LeaveStatus.approved
                                ? 'Approved'
                                : 'Pending',
                            style: TextStyle(
                              color: leave.status == LeaveStatus.approved
                                  ? AppColors.statusApproved
                                  : AppColors.statusPending,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down,
              color: AppColors.textGrey, size: 20),
        ],
      ),
    );
  }
}

class _ApplyLeaveSheet extends StatefulWidget {
  const _ApplyLeaveSheet();

  @override
  State<_ApplyLeaveSheet> createState() => _ApplyLeaveSheetState();
}

class _ApplyLeaveSheetState extends State<_ApplyLeaveSheet> {
  LeaveType? _selectedType;
  DateTimeRange? _selectedRange;

  Future<void> _pickDates() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (range != null) setState(() => _selectedRange = range);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Apply for Leave',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          const Text('Leave Type',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          DropdownButtonFormField<LeaveType>(
            value: _selectedType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            hint: const Text('Select leave type'),
            items: LeaveType.values.map((t) {
              final labels = {
                LeaveType.vacation: 'Vacation',
                LeaveType.casualLeave: 'Casual Leave',
                LeaveType.sick: 'Sick',
                LeaveType.parental: 'Parental',
              };
              return DropdownMenuItem(
                  value: t, child: Text(labels[t] ?? ''));
            }).toList(),
            onChanged: (v) => setState(() => _selectedType = v),
          ),
          const SizedBox(height: 14),
          const Text('Select Dates',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickDates,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.inputBorder),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _selectedRange == null
                    ? 'Tap to choose dates'
                    : '${DateFormat('dd MMM yyyy').format(_selectedRange!.start)} → ${DateFormat('dd MMM yyyy').format(_selectedRange!.end)}',
                style: TextStyle(
                  color: _selectedRange == null
                      ? AppColors.textLight
                      : AppColors.textDark,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Submit Leave Request'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
