import '../l10n/app_localizations.dart';
import '../services/geo_service.dart';

extension NearbyVolunteerPinL10n on NearbyVolunteerPin {
  /// نص مختصر لنافذة الخريطة.
  String volunteerMapSnippet(AppLocalizations l10n) {
    final skills = serviceKeys.map((k) => _serviceKeyLabel(k, l10n)).take(2).join(' · ');
    return '${l10n.mapKmAway(km.toStringAsFixed(1))} · ★${rating.toStringAsFixed(1)} · $skills';
  }

  String volunteerTitle(AppLocalizations l10n) {
    final i = int.tryParse(id.replaceFirst('v', '')) ?? 0;
    switch (i) {
      case 0:
        return l10n.mockVolunteerName0;
      case 1:
        return l10n.mockVolunteerName1;
      case 2:
        return l10n.mockVolunteerName2;
      default:
        return l10n.mockVolunteerName3;
    }
  }

  String volunteerDetailLine(AppLocalizations l10n) {
    final skills = serviceKeys.map((k) => _serviceKeyLabel(k, l10n)).take(3).join(' · ');
    return '${l10n.mapKmAway(km.toStringAsFixed(1))} · ★${rating.toStringAsFixed(1)} · '
        '${l10n.volunteerCompletedCount(completedServices)} · $skills';
  }
}

String _serviceKeyLabel(String k, AppLocalizations l10n) {
  switch (k) {
    case 'carry':
      return l10n.serviceCarry;
    case 'shop':
      return l10n.serviceShopping;
    case 'escort':
      return l10n.serviceEscort;
    case 'clean':
      return l10n.serviceCleaning;
    case 'med':
      return l10n.serviceMedicine;
    case 'other':
      return l10n.serviceOther;
    default:
      return k;
  }
}
