import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/language_switcher.dart';
import 'disability_dashboard_screen.dart';
import 'volunteer_dashboard_screen.dart';

/// For users who are both disability and volunteer — tabbed home.
class CombinedHomeScreen extends StatefulWidget {
  const CombinedHomeScreen({super.key});

  @override
  State<CombinedHomeScreen> createState() => _CombinedHomeScreenState();
}

class _CombinedHomeScreenState extends State<CombinedHomeScreen> {
  int _index = 0;

  void _sos(AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.sosSent), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardGreeting(app.userName)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
            tooltip: l10n.notifications,
          ),
          if (_index == 0)
            IconButton(
              icon: const Icon(Icons.emergency_share_rounded),
              color: AppColors.coral,
              onPressed: () => _sos(l10n),
              tooltip: l10n.sosEmergency,
            ),
          IconButton(
            icon: const Icon(Icons.person_outline_rounded),
            onPressed: () => context.push('/profile'),
            tooltip: l10n.profileTitle,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 4, right: 12),
            child: LanguageSwitcher(),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: const [
          DisabilityDashboardScreen(embedded: true),
          VolunteerDashboardScreen(embedded: true),
        ],
      ),
      floatingActionButton: _index == 1
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/report'),
              backgroundColor: AppColors.coral,
              icon: const Icon(Icons.flag_rounded),
              label: Text(l10n.reportIssue),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.favorite_outline_rounded),
            selectedIcon: const Icon(Icons.favorite_rounded),
            label: l10n.requestsTab,
          ),
          NavigationDestination(
            icon: const Icon(Icons.volunteer_activism_outlined),
            selectedIcon: const Icon(Icons.volunteer_activism_rounded),
            label: l10n.volunteerTab,
          ),
        ],
      ),
    );
  }
}
