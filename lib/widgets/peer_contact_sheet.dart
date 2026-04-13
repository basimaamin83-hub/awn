import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

Future<void> showPeerContactSheet(
  BuildContext context, {
  required bool volunteerSide,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final app = context.read<AppState>();
  final locale = Localizations.localeOf(context);
  final name = app.peerFullNameInService(volunteerSide, locale);
  final photo = app.peerPhotoInService(volunteerSide);
  final phone = app.peerPhoneInService(volunteerSide);

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 8,
          bottom: MediaQuery.paddingOf(ctx).bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.peerContactTitle,
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ClipOval(
              child: Image.network(
                photo,
                width: 112,
                height: 112,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 112,
                  height: 112,
                  color: AppColors.olivePale,
                  alignment: Alignment.center,
                  child: const Icon(Icons.person_rounded, size: 48, color: AppColors.olive),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              textAlign: TextAlign.center,
              style: Theme.of(ctx).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              volunteerSide ? l10n.roleBadgeDisability : l10n.roleBadgeVolunteer,
              style: Theme.of(ctx).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final uri = Uri.parse('tel:${phone.replaceAll(' ', '')}');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else if (ctx.mounted) {
                        ScaffoldMessenger.of(ctx).showSnackBar(
                          SnackBar(content: Text(l10n.callCouldNotOpen)),
                        );
                      }
                    },
                    icon: const Icon(Icons.call_rounded),
                    label: Text(l10n.callButton),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (context.mounted) {
                          context.push(volunteerSide ? '/chat?volunteer=1' : '/chat?volunteer=0');
                        }
                      });
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.rainbowIndigo,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.chat_rounded),
                    label: Text(l10n.chatButton),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
