import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/language_switcher.dart';
import '../widgets/maps/awn_nearby_map.dart';

class VolunteerDashboardScreen extends StatelessWidget {
  const VolunteerDashboardScreen({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppState>();

    final body = ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            color: app.volunteerAvailable
                ? AppColors.olivePale
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            child: SwitchListTile(
              value: app.volunteerAvailable,
              onChanged: (v) => app.setVolunteerAvailable(v),
              title: Text(
                l10n.availableNow,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(l10n.availableNowHint),
              secondary: Icon(
                Icons.radar_rounded,
                color: app.volunteerAvailable ? AppColors.olive : AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.mapNearbyRequestsTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          const AwnNearbyMap(role: NearbyMapRole.volunteerSeesRequests, height: 240),
          const SizedBox(height: 20),
          ...List.generate(
            2,
            (i) => Card(
              child: ListTile(
                leading: const Icon(Icons.place_rounded, color: AppColors.coral),
                title: Text('${l10n.serviceCarry} · 1.${i + 2} km'),
                subtitle: Text(l10n.mockLocation),
                trailing: FilledButton(
                  onPressed: () => context.push('/service?role=volunteer'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.olive,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Text(l10n.continueButton),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.scheduledRequests,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Card(
            child: ListTile(
              title: Text(l10n.serviceEscort),
              subtitle: const Text('Thu 10:00'),
              trailing: const Icon(Icons.schedule_rounded),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  label: l10n.statsServices,
                  value: '${app.servicesCompleted}',
                  icon: Icons.volunteer_activism_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  label: l10n.statsPoints,
                  value: '${app.volunteerPoints}',
                  icon: Icons.stars_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  label: l10n.statsRating,
                  value: app.volunteerRating.toStringAsFixed(1),
                  icon: Icons.star_rounded,
                ),
              ),
            ],
          ),
        ],
      );

    if (embedded) {
      return body;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardGreeting(app.userName)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
            tooltip: l10n.notifications,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 4, right: 8),
            child: LanguageSwitcher(),
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          if (i == 1) context.push('/profile');
          if (i == 2) context.push('/report');
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: l10n.homeTab,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            selectedIcon: const Icon(Icons.person_rounded),
            label: l10n.profileTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.flag_outlined),
            selectedIcon: const Icon(Icons.flag_rounded),
            label: l10n.reportIssue,
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: AppColors.olive),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
