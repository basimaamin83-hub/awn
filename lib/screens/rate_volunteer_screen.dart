import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class RateVolunteerScreen extends StatefulWidget {
  const RateVolunteerScreen({super.key});

  @override
  State<RateVolunteerScreen> createState() => _RateVolunteerScreenState();
}

class _RateVolunteerScreenState extends State<RateVolunteerScreen> {
  final Map<String, int> _stars = {
    'p': 5,
    'r': 5,
    'q': 5,
    'i': 5,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      (l10n.ratingPunctuality, 'p'),
      (l10n.ratingRespect, 'r'),
      (l10n.ratingQuality, 'q'),
      (l10n.ratingInstructions, 'i'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.submitRating)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.rateVolunteerTitle(l10n.peerVolunteerName),
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
          const SizedBox(height: 8),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: l10n.reportDescription,
            ),
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: () {
              context.go(context.read<AppState>().homeRoute);
            },
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
