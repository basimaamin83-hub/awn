import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/geo_service.dart';
import '../theme/app_theme.dart';
import 'nearby_volunteer_l10n.dart';

/// بطاقات المتطوعين القريبين (نفس بيانات الخريطة التجريبية).
class NearbyVolunteersList extends StatefulWidget {
  const NearbyVolunteersList({super.key});

  @override
  State<NearbyVolunteersList> createState() => _NearbyVolunteersListState();
}

class _NearbyVolunteersListState extends State<NearbyVolunteersList> {
  List<NearbyVolunteerPin>? _pins;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final pos = await GeoService.resolveUserPosition();
    if (!mounted) return;
    setState(() {
      _pins = GeoService.mockVolunteersAround(pos);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    final pins = _pins ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.nearbyVolunteersListTitle,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.olive,
              ),
        ),
        const SizedBox(height: 10),
        ...pins.map((v) {
          final title = v.volunteerTitle(l10n);
          final detail = v.volunteerDetailLine(l10n);
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              elevation: 0,
              color: AppColors.olivePale.withValues(alpha: 0.45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: AppColors.olive,
                  child: Text(
                    title.isNotEmpty ? title.characters.first : '?',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(detail, style: Theme.of(context).textTheme.bodySmall),
                isThreeLine: true,
              ),
            ),
          );
        }),
      ],
    );
  }
}
