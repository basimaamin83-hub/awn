import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'providers/app_state.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = AppState();
  final router = createAppRouter(appState);
  runApp(AwnApp(appState: appState, router: router));
}

class AwnApp extends StatelessWidget {
  const AwnApp({
    super.key,
    required this.appState,
    required this.router,
  });

  final AppState appState;
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>.value(
      value: appState,
      child: ListenableBuilder(
        listenable: appState,
        builder: (context, _) {
          final isRtl = appState.locale.languageCode == 'ar';
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (ctx) => AppLocalizations.of(ctx)?.appTitle ?? 'Awn',
            locale: appState.locale,
            builder: (context, child) {
              return Directionality(
                textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 5,
                      decoration: BoxDecoration(gradient: AppColors.rainbowBar),
                    ),
                    Expanded(child: child ?? const SizedBox.shrink()),
                  ],
                ),
              );
            },
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            theme: buildAwnTheme(brightness: Brightness.light),
            darkTheme: buildAwnTheme(brightness: Brightness.dark),
            themeMode: ThemeMode.light,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
