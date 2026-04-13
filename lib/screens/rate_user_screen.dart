import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class RateUserScreen extends StatefulWidget {
  const RateUserScreen({super.key});

  @override
  State<RateUserScreen> createState() => _RateUserScreenState();
}

class _RateUserScreenState extends State<RateUserScreen> {
  final Map<String, int> _stars = {
    'c': 5,
    'co': 5,
    't': 5,
    're': 5,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      (l10n.ratingClarity, 'c'),
      (l10n.ratingCooperation, 'co'),
      (l10n.ratingCommitment, 't'),
      (l10n.ratingRespectUser, 're'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.submitRating)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.rateUserTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          ...items.map((row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(child: Text(row.$1)),
                  Row(
                    children: List.generate(5, (i) {
                      final v = i + 1;
                      return IconButton(
                        onPressed: () => setState(() => _stars[row.$2] = v),
                        icon: Icon(
                          v <= (_stars[row.$2] ?? 0) ? Icons.star_rounded : Icons.star_outline_rounded,
                          color: Colors.amber.shade700,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: () => context.go(context.read<AppState>().homeRoute),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.olive,
              minimumSize: const Size.fromHeight(52),
            ),
            child: Text(l10n.submitRating),
          ),
        ],
      ),
    );
  }
}
