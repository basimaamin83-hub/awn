import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final items = [
      (Icons.check_circle_outline_rounded, AppColors.olive, l10n.notifVolunteerAccepted, '10:24'),
      (Icons.schedule_rounded, AppColors.sky, l10n.notifScheduledReminder, l10n.yesterday),
      (Icons.star_outline_rounded, Colors.amber.shade700, l10n.notifNewRating, 'Mon'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notificationsTitle)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final row = items[i];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: row.$2.withValues(alpha: 0.15),
                child: Icon(row.$1, color: row.$2),
              ),
              title: Text(row.$3),
              subtitle: Text(row.$4),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.demoSimulated)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
