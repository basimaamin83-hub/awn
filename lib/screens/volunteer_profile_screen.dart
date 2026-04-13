import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({super.key});

  @override
  State<VolunteerProfileScreen> createState() => _VolunteerProfileScreenState();
}

class _VolunteerProfileScreenState extends State<VolunteerProfileScreen> {
  final Set<String> _skills = {};
  int _regionIndex = 0;
  double _distanceKm = 10;
  final Set<String> _days = {};

  static const _regionsEn = ['Amman', 'Zarqa', 'Irbid', 'Aqaba', 'Salt'];
  static const _regionsAr = ['عمان', 'الزرقاء', 'إربد', 'العقبة', 'السلط'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    final regions = ar ? _regionsAr : _regionsEn;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.volunteerProfileTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.skillsSection,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.olive,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _skillLabels(ar).entries.map((e) {
              final key = e.key;
              final selected = _skills.contains(key);
              return FilterChip(
                label: Text(e.value),
                selected: selected,
                onSelected: (v) => setState(() {
                  if (v) {
                    _skills.add(key);
                  } else {
                    _skills.remove(key);
                  }
                }),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.regionsSection,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.olive,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                isExpanded: true,
                value: _regionIndex.clamp(0, regions.length - 1),
                items: List.generate(
                  regions.length,
                  (i) => DropdownMenuItem(value: i, child: Text(regions[i])),
                ),
                onChanged: (v) => setState(() => _regionIndex = v ?? 0),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.maxDistanceSection,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.olive,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _distanceKm,
                  min: 5,
                  max: 30,
                  divisions: 5,
                  label: '${_distanceKm.round()} km',
                  onChanged: (v) => setState(() => _distanceKm = v),
                ),
              ),
              Text('${_distanceKm.round()} km'),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.availabilitySection,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.olive,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _weekDays(ar).map((e) {
              final selected = _days.contains(e.key);
              return FilterChip(
                label: Text(e.value),
                selected: selected,
                onSelected: (v) => setState(() {
                  if (v) {
                    _days.add(e.key);
                  } else {
                    _days.remove(e.key);
                  }
                }),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () {
              final app = context.read<AppState>();
              app.setVolunteerProfileComplete(true);
              if (app.role == AppUserRole.both) {
                context.go('/home-combined');
              } else {
                context.go('/home-volunteer');
              }
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.olive),
            child: Text(l10n.submitRegistration),
          ),
        ],
      ),
    );
  }

  Map<String, String> _skillLabels(bool ar) {
    if (ar) {
      return const {
        'strength': 'قوة بدنية',
        'patience': 'صبر',
        'sign': 'لغة إشارة',
        'nurse': 'إسعاف / تمريض',
        'read': 'قراءة بصوت',
        'comm': 'تواصل',
      };
    }
    return const {
      'strength': 'Physical strength',
      'patience': 'Patience',
      'sign': 'Sign language',
      'nurse': 'First aid / nursing',
      'read': 'Reading aloud',
      'comm': 'Communication',
    };
  }

  List<MapEntry<String, String>> _weekDays(bool ar) {
    if (ar) {
      return const [
        MapEntry('sat', 'السبت'),
        MapEntry('sun', 'الأحد'),
        MapEntry('mon', 'الإثنين'),
        MapEntry('tue', 'الثلاثاء'),
        MapEntry('wed', 'الأربعاء'),
        MapEntry('thu', 'الخميس'),
        MapEntry('fri', 'الجمعة'),
      ];
    }
    return const [
      MapEntry('sat', 'Sat'),
      MapEntry('sun', 'Sun'),
      MapEntry('mon', 'Mon'),
      MapEntry('tue', 'Tue'),
      MapEntry('wed', 'Wed'),
      MapEntry('thu', 'Thu'),
      MapEntry('fri', 'Fri'),
    ];
  }
}
