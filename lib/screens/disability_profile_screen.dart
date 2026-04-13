import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class DisabilityProfileScreen extends StatefulWidget {
  const DisabilityProfileScreen({super.key});

  @override
  State<DisabilityProfileScreen> createState() => _DisabilityProfileScreenState();
}

class _DisabilityProfileScreenState extends State<DisabilityProfileScreen> {
  final Set<String> _types = {};
  final Set<String> _services = {};
  final _notes = TextEditingController();

  static const _typeKeys = [
    'mobility',
    'visual',
    'hearing',
    'intellectual',
    'autism',
    'psych',
    'chronic',
    'temporary',
  ];

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  void _save(BuildContext context) {
    final app = context.read<AppState>();
    app.setDisabilityProfileComplete(true);
    if (app.role == AppUserRole.both) {
      context.go('/volunteer-profile');
    } else {
      context.go('/home-disability');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.disabilityProfileTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _sectionTitle(context, l10n.disabilityTypeSection),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _typeKeys.map((k) {
              final selected = _types.contains(k);
              return FilterChip(
                avatar: Icon(_typeIcon(k), size: 18),
                label: Text(_typeLabel(context, k)),
                selected: selected,
                onSelected: (v) => setState(() {
                  if (v) {
                    _types.add(k);
                  } else {
                    _types.remove(k);
                  }
                }),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          _sectionTitle(context, l10n.servicesNeededSection),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _serviceChip(l10n.serviceCarry, 'carry'),
              _serviceChip(l10n.serviceShopping, 'shop'),
              _serviceChip(l10n.serviceEscort, 'escort'),
              _serviceChip(l10n.serviceCleaning, 'clean'),
              _serviceChip(l10n.serviceMedicine, 'med'),
              _serviceChip(l10n.serviceOther, 'other'),
            ],
          ),
          const SizedBox(height: 24),
          _sectionTitle(context, l10n.volunteerInstructionsSection),
          TextField(
            controller: _notes,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: l10n.additionalNotes,
            ),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () => _save(context),
            style: FilledButton.styleFrom(backgroundColor: AppColors.olive),
            child: Text(l10n.saveButton),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        t,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.olive,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  FilterChip _serviceChip(String label, String key) {
    final selected = _services.contains(key);
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (v) => setState(() {
        if (v) {
          _services.add(key);
        } else {
          _services.remove(key);
        }
      }),
    );
  }

  String _typeLabel(BuildContext context, String k) {
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    const en = {
      'mobility': 'Mobility',
      'visual': 'Visual',
      'hearing': 'Hearing',
      'intellectual': 'Intellectual',
      'autism': 'Autism spectrum',
      'psych': 'Psychological',
      'chronic': 'Chronic illness',
      'temporary': 'Temporary',
    };
    const arMap = {
      'mobility': 'حركية',
      'visual': 'بصرية',
      'hearing': 'سمعية',
      'intellectual': 'ذهنية',
      'autism': 'طيف التوحد',
      'psych': 'نفسية',
      'chronic': 'أمراض مزمنة',
      'temporary': 'مؤقتة',
    };
    return ar ? (arMap[k] ?? k) : (en[k] ?? k);
  }

  IconData _typeIcon(String k) {
    switch (k) {
      case 'mobility':
        return Icons.accessible_rounded;
      case 'visual':
        return Icons.visibility_off_rounded;
      case 'hearing':
        return Icons.hearing_rounded;
      case 'intellectual':
        return Icons.psychology_rounded;
      case 'autism':
        return Icons.diversity_3_rounded;
      case 'psych':
        return Icons.self_improvement_rounded;
      case 'chronic':
        return Icons.local_hospital_rounded;
      case 'temporary':
        return Icons.healing_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }
}
