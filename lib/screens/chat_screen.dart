import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class _ChatBubble {
  const _ChatBubble({required this.fromMe, required this.text});

  final bool fromMe;
  final String text;
}

/// دردشة فورية تجريبية: واجهة مختلفة قليلاً حسب كون المستخدم متطوعاً أو طالب مساعدة.
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.volunteerSide});

  /// `true` = أنا متطوع أتحدث مع طالب المساعدة، `false` = أنا ذو إعاقة أتحدث مع المتطوع.
  final bool volunteerSide;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final List<_ChatBubble> _items = [];
  bool _seeded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_seeded) return;
    _seeded = true;
    final l10n = AppLocalizations.of(context)!;
    _items.add(
      _ChatBubble(
        fromMe: false,
        text: widget.volunteerSide ? l10n.chatInitialFromRequester : l10n.chatInitialFromVolunteer,
      ),
    );
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send(AppLocalizations l10n) {
    final t = _input.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _items.add(_ChatBubble(fromMe: true, text: t));
      _input.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = context.watch<AppState>();

    final peerName = widget.volunteerSide ? l10n.chatDemoRequesterName : l10n.peerVolunteerName;
    final roleLine =
        widget.volunteerSide ? l10n.chatSubtitleVolunteerTalking : l10n.chatSubtitleRequesterTalking;
    final peerShort = widget.volunteerSide ? l10n.roleBadgeDisability : l10n.roleBadgeVolunteer;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.chatTitle),
            Text(
              peerName,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
                  ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Material(
            color: AppColors.olivePale.withValues(alpha: 0.35),
            child: ListTile(
              dense: true,
              leading: Icon(
                widget.volunteerSide ? Icons.volunteer_activism_rounded : Icons.accessible_rounded,
                color: AppColors.olive,
              ),
              title: Text(roleLine),
              subtitle: Text('${l10n.roleBadgeDisability} ↔ ${l10n.roleBadgeVolunteer}'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: _items.length,
              itemBuilder: (context, i) {
                final m = _items[i];
                return _BubbleRow(
                  fromMe: m.fromMe,
                  text: m.text,
                  meName: app.userName,
                  peerLabel: peerShort,
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(l10n),
                      decoration: InputDecoration(
                        hintText: l10n.chatInputHint,
                        filled: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () => _send(l10n),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.olive,
                      padding: const EdgeInsets.all(16),
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.send_rounded, size: 22),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BubbleRow extends StatelessWidget {
  const _BubbleRow({
    required this.fromMe,
    required this.text,
    required this.meName,
    required this.peerLabel,
  });

  final bool fromMe;
  final String text;
  final String meName;
  final String peerLabel;

  @override
  Widget build(BuildContext context) {
    final bg = fromMe ? AppColors.olive : Theme.of(context).colorScheme.surfaceContainerHighest;
    final fg = fromMe ? Colors.white : Theme.of(context).colorScheme.onSurface;
    return Align(
      alignment: fromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.82),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(fromMe ? 18 : 4),
            bottomRight: Radius.circular(fromMe ? 4 : 18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fromMe ? meName : peerLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: fg.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: 4),
            Text(text, style: TextStyle(color: fg, height: 1.35)),
          ],
        ),
      ),
    );
  }
}
