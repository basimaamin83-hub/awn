import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppState>();
    final isAr = app.locale.languageCode == 'ar';

    return SegmentedButton<bool>(
      segments: [
        ButtonSegment(value: true, label: Text(l10n.arabic)),
        ButtonSegment(value: false, label: Text(l10n.english)),
      ],
      selected: {isAr},
      onSelectionChanged: (s) {
        app.setLocale(Locale(s.first ? 'ar' : 'en'));
      },
    );
  }
}
