import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.background,
      body: Column(
        children: [
          const CustomAppBar(title: 'Notifications'),
          Expanded(
            child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) {
          final ok = i % 2 == 0;
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: cs.onBackground.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: Row(
              children: [
                Icon(ok ? Icons.check_circle : Icons.info, color: ok ? Colors.green : cs.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ok ? 'Payment received' : 'New announcement', style: TextStyle(color: cs.onBackground, fontWeight: FontWeight.w600)),
                      Text('Today 10:30 AM', style: TextStyle(color: cs.onBackground.withValues(alpha: 0.6), fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
