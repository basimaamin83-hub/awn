import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/language_switcher.dart';

class GuestInfoScreen extends StatelessWidget {
  const GuestInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.guestTitle),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16, left: 16),
            child: LanguageSwitcher(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                l10n.guestBody,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go('/login'),
            style: FilledButton.styleFrom(backgroundColor: AppColors.olive),
            child: Text(l10n.loginWithSand),
          ),
        ],
      ),
    );
  }
}
