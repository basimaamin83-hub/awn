import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String _roleLabel(AppLocalizations l10n, AppUserRole role) {
    switch (role) {
      case AppUserRole.disability:
        return l10n.roleBadgeDisability;
      case AppUserRole.volunteer:
        return l10n.roleBadgeVolunteer;
      case AppUserRole.both:
        return l10n.roleBadgeBoth;
      case AppUserRole.guest:
        return l10n.browseAsGuest;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppState>();
    final isVolunteer = app.role == AppUserRole.volunteer || app.role == AppUserRole.both;
    final locale = Localizations.localeOf(context);
    final fullName = app.userFullNameFor(locale);
    final initial = fullName.trim().isNotEmpty
        ? String.fromCharCode(fullName.runes.first)
        : '?';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: CircleAvatar(
              radius: 56,
              backgroundColor: AppColors.olivePale,
              backgroundImage: NetworkImage(app.userPhotoUrl),
              onBackgroundImageError: (_, __) {},
              child: Text(
                initial,
                style: const TextStyle(fontSize: 40, color: AppColors.olive),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            fullName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            app.userName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Chip(
              avatar: Icon(
                Icons.verified_outlined,
                size: 18,
                color: AppColors.olive,
              ),
              label: Text(_roleLabel(l10n, app.role)),
              backgroundColor: AppColors.olivePale,
            ),
          ),
          if (isVolunteer) ...[
            const SizedBox(height: 12),
            Text(
              '${l10n.statsPoints}: ${app.volunteerPoints} · ${l10n.statsRating}: ${app.volunteerRating.toStringAsFixed(1)}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: Text(l10n.notificationsTitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/notifications'),
          ),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: Text(l10n.editProfile),
            onTap: () {
              if (app.role == AppUserRole.disability || app.role == AppUserRole.both) {
                context.push('/disability-profile');
              } else if (app.role == AppUserRole.volunteer) {
                context.push('/volunteer-profile');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.flag_outlined, color: AppColors.coral),
            title: Text(l10n.reportIssue),
            onTap: () => context.push('/report'),
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: Text(l10n.signOut),
            onTap: () => context.go('/login'),
          ),
        ],
      ),
    );
  }
}
