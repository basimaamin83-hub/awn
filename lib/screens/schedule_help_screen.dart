import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class ScheduleHelpScreen extends StatefulWidget {
  const ScheduleHelpScreen({super.key});

  @override
  State<ScheduleHelpScreen> createState() => _ScheduleHelpScreenState();
}

class _ScheduleHelpScreenState extends State<ScheduleHelpScreen> {
  String? _selected;
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _time = const TimeOfDay(hour: 10, minute: 0);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final services = [
      (l10n.serviceCarry, Icons.inventory_2_rounded, 'carry'),
      (l10n.serviceShopping, Icons.shopping_cart_rounded, 'shop'),
      (l10n.serviceEscort, Icons.directions_walk_rounded, 'escort'),
      (l10n.serviceCleaning, Icons.cleaning_services_rounded, 'clean'),
      (l10n.serviceMedicine, Icons.medication_rounded, 'med'),
      (l10n.serviceOther, Icons.add_circle_outline_rounded, 'other'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.scheduleHelp)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.whatDoYouNeed, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: services.map((s) {
              final sel = _selected == s.$3;
              return ChoiceChip(
                label: Text(s.$1),
                selected: sel,
                onSelected: (_) => setState(() => _selected = s.$3),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          ListTile(
            title: Text(l10n.pickDate),
            subtitle: Text(MaterialLocalizations.of(context).formatFullDate(_date)),
            trailing: const Icon(Icons.calendar_month_rounded),
            onTap: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (d != null) setState(() => _date = d);
            },
          ),
          ListTile(
            title: Text(l10n.pickTime),
            subtitle: Text(_time.format(context)),
            trailing: const Icon(Icons.schedule_rounded),
            onTap: () async {
              final t = await showTimePicker(context: context, initialTime: _time);
              if (t != null) setState(() => _time = t);
            },
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_on_rounded, color: AppColors.coral),
              title: Text(l10n.mockLocation),
            ),
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: _selected == null
                ? null
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.scheduleRequest)),
                    );
                    context.pop();
                  },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.deepTeal,
              minimumSize: const Size.fromHeight(54),
            ),
            child: Text(l10n.scheduleRequest),
          ),
        ],
      ),
    );
  }
}
