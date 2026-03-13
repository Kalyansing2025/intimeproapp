// ============================================================
// MODULE: Settings | SpecKit Specs: FR-SET-001 to FR-SET-004
// FR-SET-001: Show account/profile settings
// FR-SET-002: Toggle notification preferences
// FR-SET-003: Toggle private time mode
// FR-SET-004: Logout functionality
// ============================================================
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/dark_header.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;
  bool _appNotificationsEnabled = true;

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: Column(
        children: [
          DarkHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Settings',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 12, bottom: 90),
              children: [
                // Account Section
                _SectionHeader(title: AppStrings.account, icon: Icons.account_circle_outlined),
                _SettingsItem(title: AppStrings.editProfile, onTap: () {}),
                _SettingsItem(title: AppStrings.changePassword, onTap: () {}),

                const SizedBox(height: 8),
                // Notifications Section
                _SectionHeader(title: AppStrings.notificationsSettings, icon: Icons.notifications_outlined),
                _SettingsToggleItem(
                  title: AppStrings.notificationsSettings,
                  value: _notificationsEnabled,
                  onChanged: (v) => setState(() => _notificationsEnabled = v),
                ),
                _SettingsToggleItem(
                  title: AppStrings.appNotifications,
                  value: _appNotificationsEnabled,
                  onChanged: (v) => setState(() => _appNotificationsEnabled = v),
                ),

                const SizedBox(height: 8),
                // Private Time Section
                _SectionHeader(title: AppStrings.setPrivateTime, icon: Icons.lock_clock_outlined),
                _SettingsItem(
                  title: AppStrings.disablePrivateTime,
                  trailing: const Icon(Icons.check, color: AppColors.primary, size: 18),
                  onTap: () {},
                ),
                _SettingsItem(title: AppStrings.set15Mins, onTap: () {}),
                _SettingsItem(title: AppStrings.set30Mins, onTap: () {}),

                const SizedBox(height: 8),
                // Logout Section
                _SectionHeader(title: AppStrings.logout, icon: Icons.logout),
                _SettingsItem(
                  title: AppStrings.logoutAll,
                  trailing: const Icon(Icons.open_in_new, color: AppColors.textGrey, size: 16),
                  onTap: _logout,
                ),
                _SettingsItem(
                  title: AppStrings.logoutDevice,
                  trailing: const Icon(Icons.open_in_new, color: AppColors.textGrey, size: 16),
                  onTap: _logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textGrey, size: 18),
          const SizedBox(width: 8),
          Text(title,
              style: const TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 13,
                fontWeight: FontWeight.w400)),
        trailing: trailing ??
            const Icon(Icons.chevron_right,
                color: AppColors.textGrey, size: 20),
        onTap: onTap,
        dense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      ),
    );
  }
}

class _SettingsToggleItem extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool) onChanged;

  const _SettingsToggleItem({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 13,
                fontWeight: FontWeight.w400)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
        dense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      ),
    );
  }
}
