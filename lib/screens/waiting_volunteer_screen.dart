import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class WaitingVolunteerScreen extends StatefulWidget {
  const WaitingVolunteerScreen({super.key});

  @override
  State<WaitingVolunteerScreen> createState() => _WaitingVolunteerScreenState();
}

class _WaitingVolunteerScreenState extends State<WaitingVolunteerScreen> {
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _t = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/service');
      }
    });
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final home = context.read<AppState>().homeRoute;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppColors.olive, strokeWidth: 3),
              const SizedBox(height: 32),
              Text(
                l10n.searchingVolunteer,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.go(home),
                child: Text(l10n.cancelRequest),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
