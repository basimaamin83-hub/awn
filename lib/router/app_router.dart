import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../screens/chat_screen.dart';
import '../screens/combined_home_screen.dart';
import '../screens/disability_dashboard_screen.dart';
import '../screens/disability_profile_screen.dart';
import '../screens/guest_info_screen.dart';
import '../screens/login_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/rate_user_screen.dart';
import '../screens/rate_volunteer_screen.dart';
import '../screens/report_issue_screen.dart';
import '../screens/request_help_screen.dart';
import '../screens/schedule_help_screen.dart';
import '../screens/service_in_progress_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/user_type_screen.dart';
import '../screens/volunteer_dashboard_screen.dart';
import '../screens/volunteer_profile_screen.dart';
import '../screens/waiting_volunteer_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter(AppState state) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: state,
    errorBuilder: (context, state) {
      final l10n = AppLocalizations.of(context);
      final app = context.read<AppState>();
      return Scaffold(
        appBar: AppBar(title: Text(l10n?.appTitle ?? 'Awn')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline_rounded, size: 56, color: Theme.of(context).colorScheme.error),
                const SizedBox(height: 16),
                Text(
                  l10n?.pageNotFound ?? 'Not found',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => context.go(app.homeRoute),
                  child: Text(l10n?.goHome ?? 'Home'),
                ),
              ],
            ),
          ),
        ),
      );
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, s) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, s) => const LoginScreen(),
      ),
      GoRoute(
        path: '/guest',
        builder: (context, s) => const GuestInfoScreen(),
      ),
      GoRoute(
        path: '/user-type',
        builder: (context, s) => const UserTypeScreen(),
      ),
      GoRoute(
        path: '/disability-profile',
        builder: (context, s) => const DisabilityProfileScreen(),
      ),
      GoRoute(
        path: '/volunteer-profile',
        builder: (context, s) => const VolunteerProfileScreen(),
      ),
      GoRoute(
        path: '/home-disability',
        builder: (context, s) => const DisabilityDashboardScreen(),
      ),
      GoRoute(
        path: '/home-volunteer',
        builder: (context, s) => const VolunteerDashboardScreen(),
      ),
      GoRoute(
        path: '/home-combined',
        builder: (context, s) => const CombinedHomeScreen(),
      ),
      GoRoute(
        path: '/request-help',
        builder: (context, s) => const RequestHelpScreen(),
      ),
      GoRoute(
        path: '/schedule-help',
        builder: (context, s) => const ScheduleHelpScreen(),
      ),
      GoRoute(
        path: '/waiting',
        builder: (context, s) => const WaitingVolunteerScreen(),
      ),
      GoRoute(
        path: '/service',
        builder: (context, state) {
          final volunteer = state.uri.queryParameters['role'] == 'volunteer';
          return ServiceInProgressScreen(volunteerSide: volunteer);
        },
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) {
          final volunteer = state.uri.queryParameters['volunteer'] == '1';
          return ChatScreen(volunteerSide: volunteer);
        },
      ),
      GoRoute(
        path: '/rate-volunteer',
        builder: (context, s) => const RateVolunteerScreen(),
      ),
      GoRoute(
        path: '/rate-user',
        builder: (context, s) => const RateUserScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, s) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/report',
        builder: (context, s) => const ReportIssueScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, s) => const NotificationsScreen(),
      ),
    ],
  );
}
