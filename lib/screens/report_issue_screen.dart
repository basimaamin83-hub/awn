import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  String _type = 'behavior';
  final _desc = TextEditingController();

  @override
  void dispose() {
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    final types = ar
        ? const [
            ('behavior', 'سلوك غير لائق'),
            ('time', 'عدم الالتزام بالموعد'),
            ('service', 'طلب غير مناسب'),
            ('tech', 'مشكلة تقنية'),
          ]
        : const [
            ('behavior', 'Inappropriate behavior'),
            ('time', 'Missed appointment'),
            ('service', 'Inappropriate request'),
            ('tech', 'Technical issue'),
          ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.reportType, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...types.map(
            (t) => ListTile(
              onTap: () => setState(() => _type = t.$1),
              leading: Icon(
                _type == t.$1
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded,
                color: _type == t.$1 ? AppColors.olive : AppColors.textSecondary,
              ),
              title: Text(t.$2),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _desc,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: l10n.reportDescription,
            ),
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.submitButton)),
              );
              context.pop();
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.coral),
            child: Text(l10n.sendButton),
          ),
        ],
      ),
    );
  }
}
