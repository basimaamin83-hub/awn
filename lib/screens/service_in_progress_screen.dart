import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/maps/service_live_map.dart';
import '../widgets/peer_contact_sheet.dart';

class ServiceInProgressScreen extends StatelessWidget {
  const ServiceInProgressScreen({super.key, required this.volunteerSide});

  /// `true` = واجهة المتطوع (يرى طالب المساعدة)، `false` = واجهة ذي الإعاقة (يرى المتطوع).
  final bool volunteerSide;

  Future<void> _callPeer(BuildContext context, AppState app) async {
    final phone = app.peerPhoneInService(volunteerSide);
    final uri = Uri.parse('tel:${phone.replaceAll(' ', '')}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.callCouldNotOpen)),
      );
    }
  }

  void _openPeer(BuildContext context) {
    showPeerContactSheet(context, volunteerSide: volunteerSide);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppState>();
    final locale = Localizations.localeOf(context);

    final peerName = app.peerFullNameInService(volunteerSide, locale);
    final peerSubtitle = volunteerSide ? l10n.requesterRole : l10n.volunteerRole;
    final peerPhoto = app.peerPhotoInService(volunteerSide);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.serviceInProgress)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            elevation: 1,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => _openPeer(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.olivePale,
                    backgroundImage: NetworkImage(peerPhoto),
                    onBackgroundImageError: (_, __) {},
                    child: Icon(
                      volunteerSide ? Icons.person_rounded : Icons.volunteer_activism_rounded,
                      color: AppColors.olive,
                    ),
                  ),
                  title: Text(peerName),
                  subtitle: Text('${peerSubtitle} · ${l10n.tapPeerOnMap}'),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star_rounded, color: Colors.amber.shade700, size: 18),
                      const Text(' 4.9'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ServiceLiveMap(
            volunteerSide: volunteerSide,
            onPeerTap: () => _openPeer(context),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _callPeer(context, app),
                  icon: const Icon(Icons.call_rounded),
                  label: Text(l10n.callButton),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => context.push(
                    volunteerSide ? '/chat?volunteer=1' : '/chat?volunteer=0',
                  ),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.olive),
                  icon: const Icon(Icons.chat_rounded),
                  label: Text(l10n.chatButton),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          if (volunteerSide)
            FilledButton(
              onPressed: () => context.go('/rate-user'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.olive,
                minimumSize: const Size.fromHeight(52),
              ),
              child: Text(l10n.finishServiceVolunteer),
            )
          else
            FilledButton(
              onPressed: () => context.go('/rate-volunteer'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.coral,
                minimumSize: const Size.fromHeight(52),
              ),
              child: Text(l10n.finishServiceUser),
            ),
        ],
      ),
    );
  }
}
