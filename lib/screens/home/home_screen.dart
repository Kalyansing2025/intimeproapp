// ============================================================
// MODULE: Home / Dashboard | SpecKit Specs: FR-HOME-001 to FR-HOME-006
// FR-HOME-001: Show user name, role & online status
// FR-HOME-002: Live running timer for active task
// FR-HOME-003: Show Check-in time
// FR-HOME-004: Display Active Time & Work Time stats
// FR-HOME-005: Task list filtered by status tabs
// FR-HOME-006: Start/Pause active task timer
// ============================================================
import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/task_model.dart';
import '../../widgets/task_card.dart';
import '../../widgets/dark_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _timer;

  // Simulated live timer for active task
  Duration _activeElapsed = const Duration(hours: 4, minutes: 18, seconds: 22);
  bool _isRunning = true;

  final String _checkIn = '09:37 am';
  final Duration _activeTime = const Duration(hours: 2, minutes: 17);
  final Duration _workTime = const Duration(hours: 3, minutes: 9);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isRunning) {
        setState(() => _activeElapsed += const Duration(seconds: 1));
      }
    });
  }

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeTask = sampleTasks
        .firstWhere((t) => t.status == TaskStatus.inProgress);

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: Column(
        children: [
          // Dark header
          DarkHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: menu + avatar + status
                Row(
                  children: [
                    const Icon(Icons.menu, color: Colors.white, size: 22),
                    const SizedBox(width: 12),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30, width: 2),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4A90D9), Color(0xFF6B3FA0)],
                        ),
                      ),
                      child: const Center(
                        child: Text('K',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Kalyansing Chanda',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          Text('Employee',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 11)),
                        ],
                      ),
                    ),
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
                              radius: 4, backgroundColor: AppColors.statusOnline),
                          SizedBox(width: 5),
                          Text(AppStrings.online,
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

                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatChip(
                      icon: Icons.login,
                      iconColor: Colors.redAccent,
                      label: AppStrings.checkInTime,
                      value: _checkIn,
                    ),
                    _StatChip(
                      icon: Icons.timer_outlined,
                      iconColor: Colors.orangeAccent,
                      label: AppStrings.activeTime,
                      value:
                          '${_activeTime.inHours.toString().padLeft(2, '0')}:${(_activeTime.inMinutes % 60).toString().padLeft(2, '0')} hrs',
                    ),
                    _StatChip(
                      icon: Icons.access_time_outlined,
                      iconColor: Colors.greenAccent,
                      label: AppStrings.timeAtWork,
                      value:
                          '${_workTime.inHours.toString().padLeft(2, '0')}:${(_workTime.inMinutes % 60).toString().padLeft(2, '0')} hrs',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Active task card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(activeTask.project,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.statusNonBillable.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppColors.statusNonBillable),
                            ),
                            child: const Text(AppStrings.nonBillable,
                                style: TextStyle(
                                    color: AppColors.statusNonBillable,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(activeTask.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white60, fontSize: 11)),
                      const SizedBox(height: 12),

                      // Timer display
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_activeElapsed),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2),
                          ),
                          Row(
                            children: [
                              _TimerActionBtn(
                                icon: _isRunning
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.orange,
                                onTap: () =>
                                    setState(() => _isRunning = !_isRunning),
                              ),
                              const SizedBox(width: 8),
                              _TimerActionBtn(
                                icon: Icons.stop,
                                color: AppColors.primary,
                                onTap: () => setState(() => _isRunning = false),
                              ),
                              const SizedBox(width: 8),
                              _TimerActionBtn(
                                icon: Icons.check,
                                color: AppColors.statusOnline,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.search,
                prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
                suffixIcon: const Icon(Icons.tune, color: AppColors.textGrey),
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

          // Tab bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontSize: 11),
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textGrey,
              indicator: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: [
                _buildTab('New', sampleTasks.where((t) => t.status == TaskStatus.newTask).length),
                _buildTab('In Progress', sampleTasks.where((t) => t.status == TaskStatus.inProgress).length),
                _buildTab('Overdue', sampleTasks.where((t) => t.status == TaskStatus.overdue).length),
                _buildTab('Complete', sampleTasks.where((t) => t.status == TaskStatus.completed).length),
              ],
            ),
          ),

          // Task list
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(4, (index) {
                final tasks = [
                  sampleTasks.where((t) => t.status == TaskStatus.newTask).toList(),
                  sampleTasks.where((t) => t.status == TaskStatus.inProgress).toList(),
                  sampleTasks.where((t) => t.status == TaskStatus.overdue).toList(),
                  sampleTasks.where((t) => t.status == TaskStatus.completed).toList(),
                ][index];
                if (tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(Icons.smartphone,
                                size: 90, color: Color(0xFFBDBDBD)),
                            Positioned(
                              bottom: 15,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFECEC),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.warning_amber_rounded,
                                    color: Color(0xFFE53935), size: 22),
                              ),
                            ),
                            const Positioned(
                              top: 0, right: 0,
                              child: Icon(Icons.auto_awesome,
                                  color: Color(0xFFFFC107), size: 16),
                            ),
                            const Positioned(
                              top: 10, left: 0,
                              child: Icon(Icons.auto_awesome,
                                  color: Color(0xFFE91E8C), size: 10),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text('No tasks here',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9E9E9E))),
                        const SizedBox(height: 4),
                        const Text('Tap + to add a new task',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFFBDBDBD))),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 90),
                  itemCount: tasks.length,
                  itemBuilder: (_, i) => TaskCard(task: tasks[i]),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Tab _buildTab(String label, int count) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (count > 0) ...[
            const SizedBox(width: 4),
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('$count',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 14),
            const SizedBox(width: 4),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13)),
          ],
        ),
        const SizedBox(height: 2),
        Text(label,
            style:
                const TextStyle(color: Colors.white60, fontSize: 10)),
      ],
    );
  }
}

class _TimerActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _TimerActionBtn(
      {required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}
