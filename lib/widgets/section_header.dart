import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// عنوان قسم موحّد في لوحات التحكم والنماذج.
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.olive,
                  ),
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}
