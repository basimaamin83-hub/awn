import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

class RequestHelpScreen extends StatefulWidget {
  const RequestHelpScreen({super.key});

  @override
  State<RequestHelpScreen> createState() => _RequestHelpScreenState();
}

class _RequestHelpScreenState extends State<RequestHelpScreen> {
  String? _selected;
  final _notes = TextEditingController();

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

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
      appBar: AppBar(title: Text(l10n.whatDoYouNeed)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.15,
            children: services.map((s) {
              final sel = _selected == s.$3;
              return Material(
                color: sel ? AppColors.olivePale : Colors.white,
                borderRadius: BorderRadius.circular(20),
                elevation: sel ? 2 : 0,
                child: InkWell(
                  onTap: () => setState(() => _selected = s.$3),
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(s.$2, size: 40, color: AppColors.olive),
                        const SizedBox(height: 10),
                        Text(
                          s.$1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.confirmLocation,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_on_rounded, color: AppColors.coral),
              title: Text(l10n.mockLocation),
              trailing: TextButton(
                onPressed: () {},
                child: Text(l10n.useMyLocation),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _notes,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: l10n.additionalNotes,
            ),
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: () {
              if (_selected == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.selectServiceError)),
                );
                return;
              }
              context.push('/waiting');
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.olive,
              minimumSize: const Size.fromHeight(54),
            ),
            child: Text(l10n.sendRequest),
          ),
        ],
      ),
    );
  }
}
