import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/awn_logo.dart';
import '../widgets/language_switcher.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.language,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const LanguageSwitcher(),
                ],
              ),
              const Spacer(),
              const Center(child: AwnLogo(size: 88)),
              const SizedBox(height: 20),
              Text(
                l10n.appTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.olive,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.appTagline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.loginSanadSubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () => context.go('/user-type'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.olive,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.badge_outlined),
                label: Text(l10n.loginWithSand),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  context.read<AppState>().setRole(AppUserRole.guest);
                  context.go('/guest');
                },
                child: Text(l10n.browseAsGuest),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
