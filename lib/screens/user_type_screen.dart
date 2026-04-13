import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  void _go(BuildContext context, AppUserRole role) {
    final app = context.read<AppState>();
    app.setRole(role);
    switch (role) {
      case AppUserRole.disability:
        context.go('/disability-profile');
        break;
      case AppUserRole.volunteer:
        context.go('/volunteer-profile');
        break;
      case AppUserRole.both:
        context.go('/disability-profile');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.chooseRoleTitle)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.onboardingHint,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 20),
            _RoleCard(
              icon: Icons.accessible_rounded,
              label: l10n.roleDisability,
              color: AppColors.sky,
              onTap: () => _go(context, AppUserRole.disability),
            ),
            const SizedBox(height: 12),
            _RoleCard(
              icon: Icons.volunteer_activism_rounded,
              label: l10n.roleVolunteer,
              color: AppColors.olive,
              onTap: () => _go(context, AppUserRole.volunteer),
            ),
            const SizedBox(height: 12),
            _RoleCard(
              icon: Icons.handshake_rounded,
              label: l10n.roleBoth,
              color: AppColors.deepTeal,
              onTap: () => _go(context, AppUserRole.both),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                final app = context.read<AppState>();
                app.setDisabilityProfileComplete(true);
                app.setVolunteerProfileComplete(true);
                app.setRole(AppUserRole.both);
                context.go('/home-combined');
              },
              child: Text(l10n.skipForDemo),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 1,
      shadowColor: color.withValues(alpha: 0.35),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: color.withValues(alpha: 0.8)),
            ],
          ),
        ),
      ),
    );
  }
}
