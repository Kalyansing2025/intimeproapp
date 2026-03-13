import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class DarkHeader extends StatelessWidget {
  final Widget child;
  final bool showTitle;
  final String? title;

  const DarkHeader({
    super.key,
    required this.child,
    this.showTitle = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
            Color(0xFF0F3460),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: child,
        ),
      ),
    );
  }
}

// Simple header for screens that just need a title + menu
class SimpleHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SimpleHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return DarkHeader(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: Colors.white, size: 22),
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          trailing ??
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
    );
  }
}
