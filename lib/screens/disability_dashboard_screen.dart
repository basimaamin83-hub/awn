import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/language_switcher.dart';
import '../widgets/maps/awn_nearby_map.dart';
import '../widgets/nearby_volunteers_list.dart';
import '../widgets/section_header.dart';

class DisabilityDashboardScreen extends StatelessWidget {
  const DisabilityDashboardScreen({super.key, this.embedded = false});

  final bool embedded;

  void _sos(BuildContext context, AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.sosSent), behavior: SnackBarBehavior.floating),
    );
  }

  void _demo(BuildContext context, AppLocalizations l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.demoSimulated)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppState>();

    final body = ListView(
      padding: const EdgeInsets.all(20),
      children: [
        FilledButton(
          onPressed: () => context.push('/request-help'),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.coral,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(64),
            textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          child: Text(l10n.urgentHelpCta),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.urgentHelpDetail,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                height: 1.35,
              ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => context.push('/schedule-help'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.deepTeal,
            side: const BorderSide(color: AppColors.deepTeal, width: 1.5),
            minimumSize: const Size.fromHeight(56),
          ),
          child: Text(l10n.scheduleHelp),
        ),
        const SizedBox(height: 24),
        SectionHeader(l10n.mapNearbyVolunteersTitle),
        const SizedBox(height: 10),
        const AwnNearbyMap(role: NearbyMapRole.disabilitySeesVolunteers, height: 240),
        const SizedBox(height: 20),
        const NearbyVolunteersList(),
        const SizedBox(height: 28),
        SectionHeader(l10n.myCurrentRequests),
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => context.push('/service'),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.olivePale,
                child: Icon(Icons.map_outlined, color: AppColors.olive),
              ),
              title: Text(l10n.mockLocation),
              subtitle: Text(l10n.volunteerAccepted),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.call_rounded),
                    onPressed: () => _demo(context, l10n),
                    tooltip: l10n.callButton,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline_rounded),
                    onPressed: () => context.push('/chat?volunteer=0'),
                    tooltip: l10n.chatButton,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SectionHeader(l10n.myPastRequests),
        ...List.generate(
          3,
          (i) => Card(
            child: ListTile(
              title: Text('${l10n.serviceShopping} · ${i + 1}/3/2026'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/schedule-help'),
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(l10n.viewAll),
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
          IconButton(
            icon: const Icon(Icons.emergency_share_rounded),
            color: AppColors.coral,
            onPressed: () => _sos(context, l10n),
            tooltip: l10n.sosEmergency,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: LanguageSwitcher(),
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          if (i == 1) context.push('/profile');
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
        ],
      ),
    );
  }
}
